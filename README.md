# Sherpa pO Collision Simulation

This repository contains a Sherpa setup for simulating proton-Oxygen (pO) collisions with asymmetric beam energies and different PDFs, demonstrating the feasibility of using Sherpa for heavy-ion physics studies.

## Physics Setup

- **Collision system**: Proton (7 TeV) + Oxygen (2.5 TeV)
- **Process**: Drell-Yan Z production (p + O → Z → μ⁺μ⁻/e⁺e⁻)
- **PDFs**:
  - Proton: CT18NLO (LHEF_PDF_NUMBER_1 = 13)
  - Oxygen: Nuclear PDF (LHEF_PDF_NUMBER_2 = 1001)
- **RIVET analyses**: MC_ZINC, MC_ZJETS (MC validation for any collision system)

## Files

- `Run.dat`: Main Sherpa configuration file
- `run_sherpa.sh`: Script to execute the simulation
- `analyze_results.sh`: Script to analyze and visualize results
- `.github/workflows/simulation.yml`: GitHub Actions workflow
- `README.md`: This documentation

## Prerequisites

1. **Sherpa**: Monte Carlo event generator
   ```bash
   # Install via conda or from source
   conda install -c conda-forge sherpa
   ```

2. **RIVET**: Analysis framework for MC validation
   ```bash
   # Install via conda or from source
   conda install -c conda-forge rivet yoda
   ```

3. **LHAPDF**: PDF library (usually included with Sherpa)
   ```bash
   # Install if needed
   conda install -c conda-forge lhapdf
   ```

## Usage

### 1. Run the simulation

```bash
# Make scripts executable
chmod +x run_sherpa.sh analyze_results.sh

# Run Sherpa simulation
./run_sherpa.sh
```

This will:
- Generate 10,000 Z production events
- Apply RIVET analyses
- Create output files in `results/` directory

### 2. Analyze results

```bash
./analyze_results.sh
```

This will:
- Generate HTML plots from RIVET analysis
- Extract basic event statistics
- Create sample event file for inspection

### 3. View results

Open `results/rivet_plots/index.html` in your browser to view:
- Z boson pT, rapidity, and mass distributions
- Comparison with experimental data
- Monte Carlo validation plots

## Key Features

### Asymmetric Beam Energies
- Proton beam: 7 TeV
- Oxygen beam: 2.5 TeV
- Demonstrates Sherpa's capability for asymmetric collisions

### Different PDFs
- Separate PDF sets for proton and oxygen
- Nuclear modifications for oxygen nucleus
- Configurable via LHEF_PDF_NUMBER parameters

### RIVET Integration
- Uses official RIVET analyses for Z production
- Validation against experimental measurements
- Automatic histogram generation and comparison

## Output Files

After running the simulation, you'll find:

- `results/sherpa_events.lhe.gz`: Generated events in LHEF format
- `results/pO_Z.yoda`: RIVET analysis data
- `results/rivet_plots/`: HTML report with plots
- `results/sherpa.log`: Sherpa runtime information

## Customization

### Change beam energies
Edit `Run.dat`:
```
BEAM_ENERGIES 7000 2500  # Proton, Oxygen in GeV
```

### Change PDFs
Edit `Run.dat`:
```
LHEF_PDF_NUMBER_1 13   # Proton PDF
LHEF_PDF_NUMBER_2 1001 # Oxygen PDF
```

### Change process
Edit the PROCESSES section in `Run.dat` to modify the physics process.

### Change number of events
Edit `Run.dat`:
```
EVENTS 10000  # Number of events to generate
```

## Troubleshooting

1. **Sherpa not found**: Ensure Sherpa is installed and in your PATH
2. **PDF errors**: Check that required PDF sets are installed
3. **RIVET errors**: Ensure RIVET and YODA are properly installed
4. **Memory issues**: Reduce number of events or increase available RAM

## GitHub Actions CI/CD

This repository includes automated simulation runs using GitHub Actions with the official [hepstore/rivet-sherpa](https://hub.docker.com/r/hepstore/rivet-sherpa/tags) Docker image.

### Automated Workflows

- **Triggers**: Push to main, pull requests, manual dispatch
- **Container**: Uses `hepstore/rivet-sherpa:latest`
- **Outputs**: Simulation results uploaded as artifacts

### Running on GitHub Actions

1. **Automatic**: Commits to main branch trigger simulation
2. **Manual**: Use the "Run workflow" button in GitHub Actions tab
3. **Custom events**: Specify number of events via workflow dispatch

### Artifacts

After successful runs, download:
- `sherpa-pO-results-###.zip`: All simulation outputs (.lhe.gz, .yoda, .log)
- `rivet-plots-###.zip`: HTML plots from RIVET analysis
- `simulation_report.md`: Summary of the run

## Physics Validation

This setup demonstrates:
- Sherpa's ability to handle asymmetric collisions
- Nuclear PDF effects in oxygen
- Drell-Yan physics in pO system
- RIVET analysis integration for validation

The results can be used to study:
- Nuclear modification of PDFs
- Energy dependence of Z production
- Validation of MC generators for heavy-ion physics
