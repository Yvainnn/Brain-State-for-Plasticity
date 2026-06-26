# SWEEP2 — Diffusion MRI Preprocessing & Analysis Pipeline

## Project Overview

**SWEEP2** is a within-participant crossover neuroimaging study investigating the effects of **acute psychosocial stress vs. placebo** on white matter microstructure, as measured by multi-shell diffusion MRI (dMRI) acquired on a 3T Siemens Prisma scanner.

The pipeline processes raw BIDS-formatted dMRI data through a full sequence of preprocessing steps before model fitting and voxel-wise statistical analysis.

---

## Experimental Design

| Factor | Details |
|---|---|
| Design | Within-participant crossover (stress vs. placebo) |
| Scanner | 3T Siemens Prisma |
| Acquisition | Multi-shell, dual phase-encoding (PA + AP) |
| Magnitude + Phase | Both saved for complex-domain denoising |
| Analysis | Voxel-wise GLM, FDR correction (FSL `fdr`), TFCE via `randomise` |
| Models | Diffusion Kurtosis (DKI), Tensor (DTI), NODDI |

---

## Pipeline Steps

### 1. MP-PCA Denoising (Complex-Domain)

**Script:** `dki.py` (denoising module) | **Tool:** MRtrix3 `dwidenoise`

Denoising is performed in the **complex domain** to avoid Rician noise bias in magnitude images.

**Workflow:**
1. Convert phase images from scanner units to radians:
   `phase_rad = phase × π / phase_range`
2. Combine magnitude + phase into complex image via `mrcalc -polar`
3. Denoise complex image with `dwidenoise` (12 threads)
4. Recover denoised magnitude via `mrcalc -abs`
5. Compute residuals: `mag_original − mag_denoised` (FSL `fslmaths`)
6. Compute noise map square root for QA: `√noise_sigma`
7. Generate squared weighted residual map for quality control
8. SlicesDir QA images generated for denoised image, noise map, and weighted residuals

**Key outputs:**

| File suffix | Content |
|---|---|
| `part-mag_dwi_denoised` | Denoised magnitude DWI |
| `part-noise` | MP-PCA noise sigma map |
| `part-sqr_wei_noise` | Squared weighted residuals (QA) |
| `part-residue` | Raw denoising residuals |

**Intermediate files removed after completion:** `part-phase-rad`, `part-complex`

---

### 2. Gibbs Ringing Correction

**Tool:** MRtrix3 `mrdegibbs`

Removes Gibbs ringing artefacts arising from k-space truncation. Applied to the denoised magnitude image before any resampling steps to maximise effectiveness.

---

### 3. Susceptibility-Induced Distortion Correction — `topup`

**Tool:** FSL `topup`

Estimates the B0 inhomogeneity field using pairs of b=0 volumes acquired with **opposite phase-encoding directions** (PA and AP). The estimated field is used downstream by `eddy` for combined motion and distortion correction.

**Inputs required:**
- b=0 volumes from PA direction
- b=0 volumes from AP direction
- Acquisition parameter file (`.acqp`)

---

### 4. Eddy Current & Motion Correction — `eddy`

**Tool:** FSL `eddy` (GPU-accelerated: `eddy_cuda` where available)

Corrects for:
- Eddy current-induced distortions
- Subject motion (rigid-body)
- Susceptibility distortions (using `topup` field estimate)

Also performs outlier slice detection and replacement.

**Key outputs:** corrected DWI, rotated bvecs, QC metrics (motion parameters, outlier report)

---

### 5. Signal Drift Correction — `sgbak_drift` / B0 Drift

**Tool:** Custom script (`FF_DWI_Drift` / `sgbak` module)

Corrects for **spatio-temporal B0 signal drift**, a systematic intensity change across the time series caused by gradient heating and scanner instability. This is particularly relevant in long multi-shell acquisitions.

Drift is modelled from interleaved b=0 volumes and used to normalise signal across the acquisition. MD (mean diffusivity) is the primary outcome sensitive to this effect.

---

### 6. Bias Field Correction

**Tool:** FSL `fast` or ANTs `N4BiasFieldCorrection`

Corrects for smooth, low-frequency intensity inhomogeneity across the volume caused by B1 field non-uniformity. Applied after eddy correction to ensure consistent signal intensity across the brain for downstream model fitting.

---

### 7. Model Fitting

#### 7a. Diffusion Kurtosis Imaging (DKI)

**Tool:** dipy / custom `dki.py`

Fits the diffusion kurtosis tensor to multi-shell data. Outputs standard DTI maps plus higher-order kurtosis metrics.

**Key outputs:** FA, MD, AD, RD, MK (mean kurtosis), AK, RK

---

#### 7b. Diffusion Tensor Imaging (DTI)

**Tool:** FSL `dtifit` or dipy

Standard single-shell or multi-shell tensor fit. Simpler model used as reference and for comparison with DKI metrics.

**Key outputs:** FA, MD, AD, RD, V1 (principal eigenvector)

---

#### 7c. NODDI

**Tool:** `AMICO` (Accelerated Microstructure Imaging via Convex Optimization)

Fits the Neurite Orientation Dispersion and Density Imaging model to multi-shell data. Provides biologically-informed tissue compartment estimates.

**Key outputs:**
- `ICVF` — Intracellular volume fraction (neurite density)
- `ODI` — Orientation Dispersion Index
- `ISOVF` — Isotropic (free water) volume fraction

---

## Statistical Analysis

- **Framework:** Voxel-wise GLM (FSL `randomise` with TFCE, or nilearn `SecondLevelModel`)
- **Design:** Mixed ANOVA — Condition (stress vs. placebo) × Time × [covariates]
- **Correction:** FDR via FSL `fdr` tool; cluster-extent filtering
- **Atlases:** MNI152, HCPex white matter atlas
- **Smoothing:** Multiple kernel sizes tested (FWHM 4, 6, 8 mm)
- **Software stack:** Python (nibabel, dipy, pingouin, nilearn, numpy, pandas, matplotlib, seaborn), FSL, MRtrix3, ANTs

---

## Directory Structure

```
project/
├── rawdata/                  # BIDS raw data
│   └── sub-XX/ses-YY/dwi/
├── derivatives/
│   └── sub-XX/ses-YY/dwi/
│       ├── prep/             # Concatenated PA+AP DWIs (input)
│       ├── denoise/          # MP-PCA denoised outputs
│       ├── gibbs/            # Gibbs-corrected
│       ├── topup/            # B0 field estimates
│       ├── eddy/             # Motion/distortion corrected
│       ├── drift/            # Drift-corrected
│       ├── bias/             # Bias-field corrected
│       ├── dki/              # DKI model maps
│       ├── dti/              # DTI model maps
│       └── noddi/            # NODDI model maps
├── logs/                     # Per-subject timestamped logs
└── scripts/
    └── DEWEY_v6/             # Pipeline scripts
```

---

## Naming Convention

Files follow BIDS-inspired naming:

```
sub-{XX}_{session}_dir-PA-AP_part-{part}_dwi_{ABC}.nii.gz
```

| Field | Description |
|---|---|
| `sub-XX` | Zero-padded subject ID |
| `session` | Session label (e.g., `ses-stress`, `ses-placebo`) |
| `dir-PA-AP` | Concatenated phase-encoding direction |
| `part-mag / phase / complex / noise` | Image part |
| `ABC` | Pipeline step suffix (e.g., concatenation identifier) |

---

## Dependencies

| Tool | Version / Notes |
|---|---|
| MRtrix3 | `dwidenoise`, `mrcalc`, `mrstats` |
| FSL | `topup`, `eddy`, `dtifit`, `fdr`, `randomise`, `fslmaths` |
| ANTs | `N4BiasFieldCorrection`, coregistration |
| dipy | DKI fitting |
| AMICO | NODDI fitting |
| nilearn | GLM, brain masking, plotting |
| Python ≥ 3.9 | nibabel, pingouin, numpy, pandas, matplotlib, seaborn |

---

*Last updated: June 2026*
