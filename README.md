# Wiseasy Sdk

Flutter plugin to communicate with Wiseasy devices

## Getting Started

Download the current [Wiseasy SDK](https://wiseasygroup.feishu.cn/wiki/QACTwUFeLi09vTk059icNb5cn3g). Here you need the `WiseSdk_**.aar` files.

After you are all setup you need to add the SDKs `\*.aar`` file to your Android Project as Module.

1. Open the android folder of your flutter project
2. In the android root folder create a single folder for `WiseSdk`, place the corresponding aar file and create an empty `build.gradle` file
3. Content of the `WiseSdk/build.gradle` file:

```groovy
configurations.maybeCreate("default")
artifacts.add("default", file('WiseSdk_D_1.08_00a_24031101.aar'))
artifacts.add("default", file('WiseSdk_P_1.28_00a_24040301.aar'))
```

4. In the android root folder find `settings.gradle` file, open it and add the following line at the top of the file:

```groovy
include ":app"
include ':WiseSdk' // Add this
```
