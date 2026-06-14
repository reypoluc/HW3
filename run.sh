#!/bin/bash

build_generator() {
    docker build -t data-generator ./generator
}

run_generator() {
    docker run --rm -v "$(pwd)/data:/data" data-generator
}

create_local_data() {
    mkdir -p data
    python3 generator/generate.py data
}


build_reporter() {
    docker build -t data-reporter ./reporter
}

run_reporter() {
    docker run --rm -v "$(pwd)/data:/data" data-reporter node report.js
}



case "$1" in
    build_generator) build_generator ;;
    run_generator) run_generator ;;
    create_local_data) create_local_data ;;
        *)
        echo "Используй:"
        echo "  build_generator"
        echo "  run_generator"
        echo "  create_local_data"
        ;;
esac