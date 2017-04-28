#!/bin/sh

# Image sizes
AND_XXXHDPI="192x192"
AND_XXHDPI="144x144"
AND_XHDPI="96x96"
AND_HDPI="72x72"
AND_MDPI="48x48"
AND_lDPI="36x36"
IOS_3X="192x192"
IOS_2X="96x96"
IOS_1X="48x48"

function printUsage
{
    echo "NativeScript Resource Generator"
    echo "Usage:  nsresgen [FILE]"
}

function display_info
{
    echo -e "\e[46m\e[37m[•]\e[0m \e[36m$1\e[0m"
}

function display_success
{
    echo -e "\e[42m\e[37m[✓]\e[0m \e[32m$1\e[0m"
}

function display_warning
{
    echo -e "\e[43m\e[37m[⚠]\e[0m \e[33m$1\e[0m"
}

function display_error
{
    echo -e "\e[41m\e[37m[x]\e[0m \e[31m$1\e[0m"
}

if [[ "$1" == "" ]] || [[ ! -f "$1" ]]; then
    display_warning "File missing"
    echo
    printUsage
    exit 2
elif [[ ! -d "./app/App_Resources" ]]; then
    display_error "This command must be invoked from within \
the root of a NativeScript project"
    exit 1
else
    display_info "File loaded: $1"
fi
