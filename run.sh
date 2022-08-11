#!/bin/sh

set -e

# intro
echo "program: flutter change bundle id"
echo "started...."

# set dir variables
WORKING_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
ANDROID_DIR=$WORKING_DIR/android/app
IOS_DIR=$WORKING_DIR/ios/Runner

# set package name
OLD_PACKAGE="com.example.helloworld"
NEW_PACKAGE="com.example.helloworld2"

# set new package name to path
IFS="." read -ra new_package_name_to_array <<< "$NEW_PACKAGE"
AFTER_PACKAGE_PATH=$ANDROID_DIR/src/main/kotlin/${new_package_name_to_array[0]}/${new_package_name_to_array[1]}/${new_package_name_to_array[2]}
echo "after package path: ${AFTER_PACKAGE_PATH}"

# set before package name to path
IFS="." read -ra old_package_name_to_array <<< "$OLD_PACKAGE"
BEFORE_PACKAGE_PATH=$ANDROID_DIR/src/main/kotlin/${old_package_name_to_array[0]}/${old_package_name_to_array[1]}/${old_package_name_to_array[2]}
echo "before package path: ${BEFORE_PACKAGE_PATH}"

## android ##
# 1. change Android application id
echo "change Android application id"
find $ANDROID_DIR/build.gradle -type f -exec sed -i "" "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +

# 2. change AndroidManifest package
echo "change AndroidManifest package"
find $ANDROID_DIR/src/main/AndroidManifest.xml -type f -exec sed -i "" "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +
find $ANDROID_DIR/src/debug/AndroidManifest.xml -type f -exec sed -i "" "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +
find $ANDROID_DIR/src/profile/AndroidManifest.xml -type f -exec sed -i "" "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +

# 3. change Android MainActivity.kt package
echo "change Android MainActivity.kt package"
find $BEFORE_PACKAGE_PATH/MainActivity.kt -type f -exec sed -i "" "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +

# 4. change Android folder structure
echo "change Android folder structure"
if [ "${old_package_name_to_array[0]}" != "${new_package_name_to_array[0]}" ]; 
then
    mv $ANDROID_DIR/src/main/kotlin/${old_package_name_to_array[0]} $ANDROID_DIR/src/main/kotlin/${new_package_name_to_array[0]}
fi

if [ "${old_package_name_to_array[1]}" != "${new_package_name_to_array[1]}" ]; 
then
    mv $ANDROID_DIR/src/main/kotlin/${old_package_name_to_array[0]}/${old_package_name_to_array[1]} $ANDROID_DIR/src/main/kotlin/${new_package_name_to_array[0]}/${new_package_name_to_array[1]}
fi

if [ "${old_package_name_to_array[2]}" != "${new_package_name_to_array[2]}" ];
then
    mv $BEFORE_PACKAGE_PATH $AFTER_PACKAGE_PATH
fi


## ios ##
# 5. change Info.plist CFBundleIdentifier
echo "change ios Info.plist CFBundleIdentifier"
find $IOS_DIR/Info.plist -type f -exec sed -i "" "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +

## flutter ##
# 6. flutter clean
echo "run command 'flutter clean'"
flutter clean
