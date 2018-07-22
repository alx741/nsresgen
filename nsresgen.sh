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
ANDROID_RES_PATH="$RES_PATH/Android/src/main/res"

printUsage()
{
    echo "NativeScript Resource Generator"
    echo "Usage:  nsresgen <copy|remove> [FILE]"
}

copyRes()
{
    FILE=$(basename "$1")
    if [ -f "$ANDROID_RES_PATH/drawable-mdpi/$FILE" ]; then
        echo
        displayWarning "The resource $FILE already exists"
        opt="n"
        read -p "Overwrite conflicting resource? [y/N]  " opt
        if [ "$opt" = "n" ] || [ "$opt" = "" ]; then
            exit 0
        fi
    fi

    echo
    displayInfo "Copying resource: $FILE"
    echo

    # Generate Android resource
    cp "$1" "$ANDROID_RES_PATH/drawable-xxxhdpi/$FILE"
    cp "$1" "$ANDROID_RES_PATH/drawable-xxhdpi/$FILE"
    cp "$1" "$ANDROID_RES_PATH/drawable-xhdpi/$FILE"
    cp "$1" "$ANDROID_RES_PATH/drawable-hdpi/$FILE"
    cp "$1" "$ANDROID_RES_PATH/drawable-mdpi/$FILE"
    cp "$1" "$ANDROID_RES_PATH/drawable-ldpi/$FILE"
    if [ "$?" = "0" ]; then displaySuccess "Android resource generated successfully"; fi

    # Generate iOS resource
    EXT="${FILE##*.}"
    BASE="${FILE%.*}"
    cp "$1" "$RES_PATH/iOS/$BASE@3x.$EXT"
    cp "$1" "$RES_PATH/iOS/$BASE@2x.$EXT"
    cp "$1" "$RES_PATH/iOS/$BASE.$EXT"
    if [ "$?" = "0" ]; then displaySuccess "iOS resource generated successfully"; fi
}

removeRes()
{
    FILE=$(basename "$1")

    echo
    displayInfo "Removing resource: $FILE"
    echo

    # Generate Android resource
    rm -f "$ANDROID_RES_PATH/drawable-xxxhdpi/$FILE"
    rm -f "$ANDROID_RES_PATH/drawable-xxhdpi/$FILE"
    rm -f "$ANDROID_RES_PATH/drawable-xhdpi/$FILE"
    rm -f "$ANDROID_RES_PATH/drawable-hdpi/$FILE"
    rm -f "$ANDROID_RES_PATH/drawable-mdpi/$FILE"
    rm -f "$ANDROID_RES_PATH/drawable-ldpi/$FILE"

    EXT="${FILE##*.}"
    BASE="${FILE%.*}"
    rm -f "$RES_PATH/iOS/$BASE@3x.$EXT"
    rm -f "$RES_PATH/iOS/$BASE@2x.$EXT"
    rm -f "$RES_PATH/iOS/$BASE.$EXT"

    displaySuccess "Resource removed"
}

genRes()
{
    FILE=$(basename "$1")
    if [ -f "$ANDROID_RES_PATH/drawable-mdpi/$FILE" ]; then
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
    convert "$1" -resize "$AND_XXXHDPI>" "$ANDROID_RES_PATH/drawable-xxxhdpi/$FILE"
    convert "$1" -resize "$AND_XXHDPI>" "$ANDROID_RES_PATH/drawable-xxhdpi/$FILE"
    convert "$1" -resize "$AND_XHDPI>" "$ANDROID_RES_PATH/drawable-xhdpi/$FILE"
    convert "$1" -resize "$AND_HDPI>" "$ANDROID_RES_PATH/drawable-hdpi/$FILE"
    convert "$1" -resize "$AND_MDPI>" "$ANDROID_RES_PATH/drawable-mdpi/$FILE"
    convert "$1" -resize "$AND_LDPI>" "$ANDROID_RES_PATH/drawable-ldpi/$FILE"
    if [ "$?" = "0" ]; then displaySuccess "Android resource generated successfully"; fi

    # Generate iOS resource
    EXT="${FILE##*.}"
    BASE="${FILE%.*}"
    convert "$1" -resize "$IOS_3X>" "$RES_PATH/iOS/$BASE@3x.$EXT"
    convert "$1" -resize "$IOS_2X>" "$RES_PATH/iOS/$BASE@2x.$EXT"
    convert "$1" -resize "$IOS_1X>" "$RES_PATH/iOS/$BASE.$EXT"
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

if [ ! -d "$RES_PATH" ]; then
    displayError "This command must be invoked from within \
the root of a NativeScript project"
    exit 1
fi

if [ "$1" == "remove" ]; then
    removeRes "${@: -1}"
    exit 0
fi

if [ "${@: -1}" = "" ] || [ ! -f "${@: -1}" ]; then
    displayWarning "File missing"
    echo
    printUsage
    exit 2
elif [ "$1" == "copy" ]; then
    copyRes "${@: -1}"
else
    displayInfo "File loaded: ${@: -1}"
    genRes "${@: -1}"
fi
