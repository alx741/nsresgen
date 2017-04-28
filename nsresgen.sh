#!/bin/sh

# Image sizes
AND_XXXHDPI="192x192"
AND_XXHDPI="144x144"
AND_XHDPI="96x96"
AND_HDPI="72x72"
AND_MDPI="48x48"
AND_LDPI="36x36"
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
    echo

    # Generate Android resource
    convert "$FILE" -resize "$AND_XXXHDPI>" "$RES_PATH/Android/drawable-xxxhdpi/$FILE"
    convert "$FILE" -resize "$AND_XXHDPI>" "$RES_PATH/Android/drawable-xxhdpi/$FILE"
    convert "$FILE" -resize "$AND_XHDPI>" "$RES_PATH/Android/drawable-xhdpi/$FILE"
    convert "$FILE" -resize "$AND_HDPI>" "$RES_PATH/Android/drawable-hdpi/$FILE"
    convert "$FILE" -resize "$AND_MDPI>" "$RES_PATH/Android/drawable-mdpi/$FILE"
    convert "$FILE" -resize "$AND_LDPI>" "$RES_PATH/Android/drawable-ldpi/$FILE"
    if [ "$?" = "0" ]; then displaySuccess "Android resource generated successfully"; fi

    # Generate iOS resource
    EXT="${FILE##*.}"
    BASE="${FILE%.*}"
    convert "$FILE" -resize "$IOS_3X>" "$RES_PATH/iOS/$BASE@3x.$EXT"
    convert "$FILE" -resize "$IOS_2X>" "$RES_PATH/iOS/$BASE@2x.$EXT"
    convert "$FILE" -resize "$IOS_1X>" "$RES_PATH/iOS/$BASE.$EXT"
    if [ "$?" = "0" ]; then displaySuccess "iOS resource generated successfully"; fi
}

function displayInfo {
    echo -e "\e[46m\e[37m[•]\e[0m \e[36m$1\e[0m"
}

function displaySuccess {
    echo -e "\e[42m\e[37m[✓]\e[0m \e[32m$1\e[0m"
}

function displayWarning {
    echo -e "\e[43m\e[37m[⚠]\e[0m \e[33m$1\e[0m"
}

function displayError {
    echo -e "\e[41m\e[37m[x]\e[0m \e[31m$1\e[0m"
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
