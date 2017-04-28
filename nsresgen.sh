#!/bin/sh

source "$(dirname "$0")/fancy.sh"

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

# Resources Path
RES_PATH="./app/App_Resources"

printUsage()
{
    echo "NativeScript Resource Generator"
    echo "Usage:  nsresgen [FILE]"
}

genRes()
{
    FILE="$1"
    if [ -f "$RES_PATH/Android/drawable-mdpi/$FILE" ]; then
        echo
        displayWarning "The resource $FILE already exists"
        opt="n"
        read -p "Overwrite conflicting resource? [y/N]  " opt
        if [ "$opt" = "n" ] || [ "$opt" = "" ]; then
            exit 0
        fi
    fi

    echo
    displayInfo "Generating resource: $FILE"
}

if [ "$1" = "" ] || [ ! -f "$1" ]; then
    displayWarning "File missing"
    echo
    printUsage
    exit 2
elif [ ! -d "$RES_PATH" ]; then
    displayError "This command must be invoked from within \
the root of a NativeScript project"
    exit 1
else
    displayInfo "File loaded: $1"
    genRes "$1" "$@"
fi
