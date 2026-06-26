# Investigating the influence of acute stress on brain tissue microstructure with dwMRI

## Authors: Alberti M., Brodt S.
### OSF- S.predicted:  Alberti, M., & Brodt, S. (2026, June 26). Investigating the influence of acute stress on brain tissue microstructure with dMRI. Retrieved from osf.io/pwjr3

### 1. Have any data been collected for this study already?
We have already started the data collection and collected the entire data sample.  

### 2. What's the main question being asked or hypothesis being tested in this study?
Diffusion-weighted MRI (dMRI) measures the degree of water molecule diffusivity within a voxel, indirectly providing information about the microstructural architecture of underlying tissue. It has been widely used to resolve white matter connectivity, and recently, to quantify short-term microstructural changes in the gray matter after learning. However, dwMRI is also sensitive to other environmental factors, including circadian rhythm or sleep pressure, which can especially bias research designs with repeated measurements.The MRI setup itself may also act as a confounding factor, triggering an acute stress response in MRI-naïve participants. We therefore investigated the effects of acute stress on brain microstructure to determine whether stress can interfere with dwMRI measurements and brain homeostasis. Additionally, we aim to regress out any interference induced by stress. First, we expect a signifcant and global increase in mean diffusivity (MD) between the stress and placebo conditions and across tissues (GM, WM and CSF). We further hypothesized that acute stress would induce local alterations in brain tissue microstructure. 
Futhermore, we assume a relationship between the extent of diffusion changes and the level of individual stress response, measured by indicators such as the STAI-S, blood pressure, heart rate, heart rate variability and salivary cortiso. Identify the effects of acute stress on dwMRI indices  whether different behavioral and peripheral physiological stress measures can influence diffusion changes.

## Hypothesis: 

### 3.  Describe the key dependent variable(s) specifying how they will be measured.
Demographic data: Each participant will be asked to fill out several questionnaires, and the following information will be collected: Age, BMI, biological sex, and, if applicable, hormonal contraception. Each participant's general emotional state will be evaluated by having them complete the STAI-T questionnaire before engaging in the first condition.

Stress markers: are collected before and after each experimental condition. Subjective stress (STAI-S), blood pressure, and heart rate are measured immediately before and after the intervention. Salivary cortisol is collected before and after stress and placebo conditions, as well as during the dMRI in 10-minute intervals, yielding five samples per condition. Respiration and heart rate are recorded during the MRI scans.

The multi-shell dwMRI acquisition is described in Table 1 and allows for a comprehensive estimation of diffusion indices with different models (Table 2) for each experimental condition. The protocol is designed to allow further partitioning into three similar sets (A, B, and C), which allow to estimate the timecourse of diffusion-tensor derived indices (DTI) across the scan duration (3 time points).


### 4.  How many and which conditions will participants be assigned to?
The experimental design is a within-subject design, in which n=40 participants will undergo a stress-inducing and a placebo control condition in two sessions during the afternoon of same day. The order is counterbalanced. Each session includes a 30-minute relaxation period followed by either the Maastricht Acute Stress Test (MAST) or a placebo-MAST, administered in counterbalanced order. After each condition, participants undergo approximately 40 minutes of dMRI. 

### 5.  Specify exactly which analyses you will conduct to examine the main question/hypothesis. 
We will determine appropriate statistical tests depending on data distribution. We will test successful stress induction by comparing stress markers before and after the intervention and between the two conditions. 
We will investigate the effect of stress induction on diffusion indices by comparing the two conditions (and the two scanning sessions) on three levels of spatial scale: Tissue-level, by averaging within gray matter, white matter and CSF voxels; region-level, by averaging voxels from a priori, anatomically defined ROIs connected to stress (Amygdala, hypothalamus, frontal cortex, hippocampus, parahippocampal, and insula {Ref}); and on the individual voxel-level. We will run these analyses separately for each diffusion index, and conduct joint inference analyses to identify common effects. The relationship between individual stress response measured by stress markers and diffusion indices will be tested  using a linear mixed model (LMM).
We will also explore differences between responders and non-responders to the stress condition.
I won’t describe any correction method

### 6.  Any secondary analyses?
Our preliminary analysis and post-hoc test revelead a signigicant signal drift in MD which result scanning session dependent, therefore we will also explore potential additional confound effects of scanning session (first vs. second scan) beyond differences in stress level.
Sex differences will be evaluated together with hormonal response to stress and demografic data.

### 7.  How many observations will be collected or what will determine the sample size? No need to justify decision, but be precise about exactly how the number will be determined. 
Participants are recruited through the university mailing. Each participant will undergo two measurement/session. They receive either the stress (administired by MAST) or placebo condition, followed by a 40min dwMRI scan. Then they repeat the procedure for the other respective condition – the order is counterbalanced. 

Sample size:  We aim to collect complete and usable datasets of 40 healthy participants (20 female). Estimation is based on effect sizes of intervention-induced changes in dwMRI ROI analyses in our previous studies {Brodt Science 2018; Klinkowski 2025 biorxiv}. With an estimated average d=0.4 we need 40 subjects to detect an effect in a two-sample t-test (α=0.05; 1-β=0.80) in the main ROI.


### 8.  Anything else you would like to pre-register? (e.g., data exclusions, variables collected for exploratory purposes, unusual analyses planned?) 
Participants will be recruited through university mailing list, they will be paid 15eu for agreeing to participate. The population is selected within healthy population between 18-35y old, additionally all the participants require a previous MRI experiment in order to join our study. The inclusion/exclusion criteria are listed below

Inclusion Criteria
    • Right-handed.
    • Age between 18 and 35 years.
    • Fluent in German & .
    • Normal vision or corrected-to-normal vision (Contac lens only).
    • Valid health insurance.

Exclusion Criteria
    • General Health & Lifestyle
    • Smoker.
    • BMI < 20 or BMI > 25.
    • Color blindness.
    • Claustrophobia (fear of enclosed spaces).
    • High sensitivity to noise.
    • Regular medication intake (except contraceptive pill).
    • Acute illness or infection in the last 4 weeks.
    • Surgery in the last 2 months.
    • Psychiatric disorders (severe depression, bipolar disorder, psychosis, obsessive-compulsive disorder, tic disorders).
    • Neurological disorders (e.g., epilepsy, Parkinson's, multiple sclerosis, stroke, meningitis).
    • Cardiac arrhythmia.
    • Pacemaker.
    • Artificial heart valves.
    • Respiratory diseases (e.g., acute infections, asthma, chronic bronchitis, tuberculosis).
    • Vascular diseases or arterial circulatory disorders.
    • Head injuries (except diagnosed concussion > 3 months ago).
    • Surgery on head or blood vessels (including teeth).
    • Metal Implants / Safety
    • Retainer larger than 4 cm.
    • Tattoos or permanent makeup.
    • Metal plates, screws, or nails after bone injuries.
    • Metal clips from surgery.
    • Metal joint prostheses or other prostheses.
    • Cerebrospinal fluid shunt.
    • Insulin pump.
    • Inner ear implants.
    • Any other active or passive implant.
    • Metal splinters or objects in the body (e.g., shrapnel).
    • Metal splinters in the eye.
    • Employment in metalworking industry.
    • Metal objects or electronics on/in the body that cannot be removed (e.g., piercings).
    • Female-Specific
    • Intrauterine device (IUD).
    • Pregnancy or breastfeeding.




### Data exclusion criteria: 
We exclude incomplete datasets as well as datasets with low MR data quality, identified by visual inspection and excessive motion.
Excessive motion will be computed during preprocessing and we aim to exclude participant whose movement in higher than 2*voxel-size. 
