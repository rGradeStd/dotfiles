#!/usr/bin/env bash

function runDots() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until the script has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    for ARG in "$@"
    do
        if [ $ARG == "additions_from_brew" ] || [ $ARG == "all" ]; then
            echo ""
            echo "------------------------------"
            echo "Installing Homebrew along with some common formulae and apps."
            echo "This might take a while to complete, as some formulae need to be installed from source."
            echo "------------------------------"
            echo ""
            ./additions_from_brew.sh
        fi
        if [ $ARG == "osx" ] || [ $ARG == "all" ]; then
            echo ""
            echo "------------------------------"
            echo "Setting sensible OSX defaults."
            echo "------------------------------"
            echo ""
            ./osx.sh
        fi
        if [ $ARG == "databases" ] || [ $ARG == "all" ]; then
            echo "------------------------------"
            echo "Setting up data stores."
            echo "------------------------------"
            echo ""
            ./databases.sh
        fi
        if [ $ARG == "vim" ] || [ $ARG == "all" ]; then
            echo "------------------------------"
            echo "Setting up vim"
            echo "------------------------------"
            echo ""
            ./vim.sh
        fi
    done

    echo "------------------------------"
    echo "Completed running .dots, restart your computer to ensure all updates take effect"
    echo "------------------------------"
}

read -p "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    runDots $@
fi;

unset runDots;

