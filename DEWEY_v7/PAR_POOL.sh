#!/usr/bin/env bash
# SWEEP2 -DEWEY parallel poo
# @M.Aberti + Claude ai

# ============================================================
# Configuration
# ============================================================
N_PPOOL=2     # Number of processes at the same time
SCRIPT="Script folder"

# Define your vps and sessions
VPS=(15 16 17 18 19 20 21 22 24 25 26 27 28 29 30 33 35 36 37 38 39 41 42 43)          # <-- e.g. vp numbers (zero-padded or not)
SESSIONS=(ses-01 ses-02) # <-- e.g. session names

# ============================================================
# Build job list
# ============================================================
jobs=()
for vp in "${VPS[@]}"; do
    for session in "${SESSIONS[@]}"; do
        jobs+=("${vp}|${session}")
    done
done

echo ""
echo " Starting | ${#jobs[@]} jobs | ${N_PPOOL} parallel"
echo ""

# ============================================================
# Run in parallel (capped at N_PPOOL)
# ============================================================
declare -A pid_map   # pid -> "vp|session"
declare -A results   # subjid -> status
running=0

run_job() {
    local vp="$1"
    local session="$2"
    local subjid="sub-$(printf '%02d' "$vp")_${session}"
    local bash_script="${SCRIPT}/bash/${subjid}_preprocessing_Denoise.sh"  # <---- Name of preprocessing scripts

    bash "$bash_script"
    return $?
}

for job in "${jobs[@]}"; do
    vp="${job%%|*}"
    session="${job##*|}"
    subjid="sub-$(printf '%02d' "$vp")_${session}"

    # Launch job in background
    run_job "$vp" "$session" &
    pid=$!
    pid_map[$pid]="${vp}|${session}"
    (( running++ ))

    # If we've hit the cap, wait for one to finish before launching more
    if (( running >= N_PPOOL )); then
        wait -n 2>/dev/null || wait   # wait -n requires bash 4.3+
        # Reap all finished pids
        for pid in "${!pid_map[@]}"; do
            if ! kill -0 "$pid" 2>/dev/null; then
                wait "$pid"
                exit_code=$?
                info="${pid_map[$pid]}"
                vp_done="${info%%|*}"
                sess_done="${info##*|}"
                subj_done="sub-$(printf '%02d' "$vp_done")_${sess_done}"
                if (( exit_code == 0 )); then
                    echo "  Done:   ${subj_done}"
                    results[$subj_done]="done"
                else
                    echo "  Try again: ${subj_done} (exit code ${exit_code})"
                    results[$subj_done]="failed"
                fi
                unset "pid_map[$pid]"
                (( running-- ))
            fi
        done
    fi
done
