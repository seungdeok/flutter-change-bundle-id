# Flutter change bundle id

## Platfrom
- android
- ios

## Pre-requirement
- [x] shell script permission:
```command
chmod run.sh 777
```

- [x] run.sh
  - Place it at the root of your flutter project (ex. flutter_project/run.sh)

- [x] set package names
```sh
# run.sh
...
# set package name
OLD_PACKAGE="com.example.helloworld"
NEW_PACKAGE="com.example.helloworld2"
...
```

## Usage
```sh
sh run.sh
```

## Change Log
- 2022.8.11
  - init

## License

MIT