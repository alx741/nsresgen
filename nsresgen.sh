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
    # echo "This command must be invoked from within the root of a NS project"
}
