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


structure() {
    find . -not -path '*/\.*' | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

clear_data() {
    rm -f data/*.csv data/*.html
}

inside_generator() {
    docker run --rm -it -v "$(pwd)/data:/data" data-generator /bin/bash
}

inside_reporter() {
    docker run --rm -it -v "$(pwd)/data:/data" data-reporter /bin/sh
}


case "$1" in
    build_generator) build_generator ;;
    run_generator) run_generator ;;
    create_local_data) create_local_data ;;
    build_reporter) build_reporter ;;
    run_reporter) run_reporter ;;
    structure) structure ;;
    clear_data) clear_data ;;
    inside_generator) inside_generator ;;
    inside_reporter) inside_reporter ;;
    *)
        echo "Используй:"
        echo "  build_generator"
        echo "  run_generator"
        echo "  create_local_data"
        echo "  build_reporter"
        echo "  run_reporter"
        echo "  structure"
        echo "  clear_data"
        echo "  inside_generator"
        echo "  inside_reporter"
        ;;
esac