#!/bin/bash

# Run script for Sherpa pO collision simulation
# Proton (7 TeV) + Oxygen (2.5 TeV) Z production

echo "Starting Sherpa simulation for pO -> Z production"
echo "Beam configuration: Proton (7 TeV) + Oxygen (2.5 TeV)"
echo "PDFs: Proton (CT18NLO) + Oxygen (nuclear PDF)"
echo ""

# Check if Sherpa is available
if ! command -v Sherpa &> /dev/null; then
    echo "Error: Sherpa not found in PATH"
    echo "Please ensure Sherpa is properly installed and in your PATH"
    exit 1
fi

# Check if RIVET is available
if ! command -v rivet &> /dev/null; then
    echo "Warning: RIVET not found in PATH"
    echo "RIVET analysis will not be performed"
fi

# Create output directory
mkdir -p results
cd results

# Run Sherpa
echo "Running Sherpa..."
Sherpa -f ../Run.dat

# Check if simulation completed successfully
if [ $? -eq 0 ]; then
    echo ""
    echo "Sherpa simulation completed successfully!"
    echo ""

    # Check for output files
    if [ -f "pO_Z.yoda" ]; then
        echo "RIVET analysis output found: pO_Z.yoda"
        echo "You can analyze results with: rivet-mkhtml pO_Z.yoda"
    fi

    if [ -f "sherpa_events.lhe.gz" ]; then
        echo "LHEF events file created: sherpa_events.lhe.gz"
    fi

    echo ""
    echo "Simulation summary:"
    echo "- Events generated: $(grep -c "<event>" sherpa_events.lhe.gz 2>/dev/null || echo 'N/A')"
    echo "- RIVET analyses: MC_ZINC, MC_ZJETS (MC validation for pO collisions)"

else
    echo "Error: Sherpa simulation failed!"
    exit 1
fi
