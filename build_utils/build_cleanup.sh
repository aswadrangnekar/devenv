#!/bin/bash

# Check and cleanup script for jenkins builds
# On the jenkins server this file is to be placed and location below.
# /var/lib/jenkins/workspace/build_cleanup.sh

PROJECT_WORKSPACE=/var/lib/jenkins/workspace


help(){
    echo "Usage: $0 [OPTION]..."
    echo "Cleanup and check script for Jenkins"
    echo "  -h, --help         Show this help output"
    echo "  -l, --lint         Run pylint checks and some extra custom style checks"
    echo "  -p, --pep8         Run pep8 checks"
    echo "  -g, --git          Run git checks (correct commit message, etc)"
    echo "  -sc, --stylecheck  Run pep8 and pylint checks"
    exit 0;
}

run_lint_check(){
    echo -n "> Running pylint..."
    pylint ./* --rcfile=".pylintrc" -r n
    echo "SUCCESS"
}

run_pep8_check(){
    # FLAKE 8
    # H802: git commit title should be under 50 chars
    # H803: git title must end with a period
    # H701: empty localization string
    FLAKE8_IGNORE="H802,H803,H701"
    # exclude settings files and virtualenvs
    FLAKE8_EXCLUDE="./web/migrations/*"
    echo "> Running flake8..."
    flake8 --ignore=$FLAKE8_IGNORE --exclude=$FLAKE8_EXCLUDE ./*
}

run_container_cleaner(){
    echo "***** Cleaning all docker containers and images *****"

    containers = $(docker ps -a -q)
    echo "> Stop all containers ..."
    if [ ! -z $containers ]; then
        docker stop $(docker ps -a -q)
    else
        echo "No containers found..."
    fi

    echo "> Delete all containers ..."
    if [ ! -z $containers ]; then
        docker rm $(docker ps -a -q)
    else
        echo "Nothing to delete..."
    fi

    echo "> Delete all images ..."
    if [ ! -z "$(docker images -q)" ]; then
        docker rmi -f $(docker images -q)
    else
        echo "No images to delete..."
fi
}

# Determine script behavior based on passed options

# default behavior
pep8=0
lint_checks=0
testargs=""
all_style_checks=0

while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help) shift; help;;
        -l|--lint) shift; lint_checks=1;;
        -p|--pep8) shift; pep8_checks=1;;
        -sc|--stylecheck) shift; all_style_checks=1;;
        *) testargs="$testargs $1"; shift;
    esac
done


if [ $lint_checks -eq 1 ]; then
    run_lint_check
    exit $?
fi

if [ $pep8_checks -eq 1 ]; then
    run_pep8_check
    exit $?
fi

if [ $all_style_checks -eq 1 ]; then
    run_pep8_check
    run_lint_check
    exit $?
fi

run_container_cleaner || exit
