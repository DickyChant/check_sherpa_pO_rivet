#!/bin/bash

# Analysis script for pO collision results

echo "Analyzing pO collision simulation results"
echo ""

# Check if we're in the results directory
if [ ! -f "pO_Z.yoda" ]; then
    if [ -d "results" ]; then
        cd results
    else
        echo "Error: No results directory found and pO_Z.yoda not in current directory"
        echo "Please run the simulation first with ./run_sherpa.sh"
        exit 1
    fi
fi

# Generate HTML report with RIVET
if [ -f "pO_Z.yoda" ]; then
    echo "Generating RIVET HTML report..."
    rivet-mkhtml pO_Z.yoda -o rivet_plots

    if [ $? -eq 0 ]; then
        echo "HTML report generated in: rivet_plots/"
        echo "Open rivet_plots/index.html in your browser to view results"
    else
        echo "Warning: Failed to generate HTML report"
    fi
else
    echo "Warning: No RIVET output file (pO_Z.yoda) found"
fi

# Basic event statistics
if [ -f "sherpa_events.lhe.gz" ]; then
    echo ""
    echo "Event statistics:"
    echo "- Total events: $(zgrep -c "<event>" sherpa_events.lhe.gz 2>/dev/null || echo 'N/A')"

    # Extract some basic info from LHEF
    echo "- Extracting particle information..."
    zgrep "<event>" -A 20 sherpa_events.lhe.gz | head -40 > event_sample.txt
    echo "  Sample event saved to: event_sample.txt"
fi

# Check for log files
if [ -f "sherpa.log" ]; then
    echo ""
    echo "Sherpa log summary:"
    echo "- Cross section: $(grep "Total XS" sherpa.log | tail -1 || echo 'N/A')"
    echo "- Integration efficiency: $(grep "integration efficiency" sherpa.log | tail -1 || echo 'N/A')"
fi

echo ""
echo "Analysis complete!"
echo "Check the following files:"
echo "- rivet_plots/index.html (if RIVET analysis was successful)"
echo "- event_sample.txt (sample event structure)"
echo "- sherpa.log (Sherpa runtime information)"
