#!/bin/sh

set -e

# intro
echo "program: flutter change bundle id"
echo "started...."

# set dir variables
WORKING_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
ANDROID_DIR=$WORKING_DIR/android/app
IOS_DIR=$WORKING_DIR/ios/Runner

# set new package name
read -p "new package(ex. com.example.helloworld): " NEW_PACKAGE

IFS="." read -ra package_name_to_array <<< "$NEW_PACKAGE"
P_LEN="${#package_name_to_array[@]}"
echo "new package to array length: $P_LEN"

if [ "$P_LEN" == 3 ]; then
    AFTER_PACKAGE_PATH=$ANDROID_DIR/src/main/kotlin/${package_name_to_array[0]}/${package_name_to_array[1]}/${package_name_to_array[2]}
    echo "after package path: ${AFTER_PACKAGE_PATH}"
else 
    echo "package name is invalid"
    exit 1
fi

# set before package name
ANDROID_BUILD_GRADLE_PATH="$ANDROID_DIR/build.gradle"

# line number
# grep -n applicationId $ANDROID_BUILD_GRADLE_PATH | cut -d: -f1 | head -1 | 
# echo $TEMP_LINE
# sed -n '/applicationId/p' $ANDROID_BUILD_GRADLE_PATH
# sed -i '/applicationId/s/g' $ANDROID_BUILD_GRADLE_PATH
# sed '/applicationId/' $ANDROID_BUILD_GRADLE_PATH 

# android
# 1. change application id
# cat $ANDROID_DIR/build.gradle

# 2. change package and label
# cat $ANDROID_DIR/src/main/AndroidManifest.xml
# cat $ANDROID_DIR/src/debug/AndroidManifest.xml
# cat $ANDROID_DIR/src/profile/AndroidManifest.xml

# 3. change MainActivity.kt package
# cat $ANDROID_DIR/src/main/kotlin/$BEFORE_PACKAGE_PATH/MainActivity.kt

# 4. change folder structure
# cat $ANDROID_DIR/src/main/kotlin/$AFTER_PACKAGE_PATH/MainActivity.kt

# ios
# 5. change Info.plist CFBundleIdentifier
# cat $IOS_DIR/Info.plist

# 6. flutter clean
# flutter clean
