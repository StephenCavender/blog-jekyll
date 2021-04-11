---
title: MacOS OpenJDK Maintenance
date: 2021-03-21
modified: 2021-04-10
categories: []
tags: [java, openjdk, dev-setup]
excerpt: Maintaining multiple OpenJDK versions on MacOS
classes: wide
header:
  overlay_image: /assets/images/posts/macos-openjdk-maintenance/header.jpg
  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
  caption: "Photo by [Jonas Jacobsson](https://unsplash.com/@jonasjacobsson) on [Unsplash](https://unsplash.com)"
---

## What is OpenJDK?

An open-source implementation of the Java platform SE. To read more check out [official site](https://openjdk.java.net/).

## Why have multiple versions?

Why not? Not all apps are able to keep up with Java versions and those that do might need some time when a new version comes out. For example: I'm working with React-Native building mobile apps for both iOS and Android. To build the Android app it uses Gradle 6.5 which doesn't support the latest version of Java (16) yet.

## Installing

I have OpenJDK installed through AdoptOpenJDK using brew. I like to keep all my apps and libs as up-to-date as possible so I run `brew upgrade` a lot. One of those times it upgraded AdoptOpenJDK to 16. Lucky for me they also publish older versions on brew but there's an extra step.

My initial thought was to run `brew install adoptopenjdk@15` but it didn't work. The versioned casks are contained in their Tap which I found out by checking out their [brew page](https://formulae.brew.sh/cask/adoptopenjdk#default) and subsequently their [open-source tap code](https://github.com/AdoptOpenJDK/homebrew-openjdk).

So the fix was to get into the tap (`brew tap adoptopenjdk/openjdk`) and run the command above again.

## Switching between versions

Now I have two versions of OpenJDK available to my system: 16 and 15. To switch between them I found a little function to pop into my .zshrc file:

```
jdk() {
  export JAVA_VERSION=$1
  java -version
}
```

Now to switch between JDK versions I run `jdk 15` or any version I have installed.

Thanks for reading! Please share using any of the buttons below and stay tuned for more. Don't hesitate to reach out in the comments below or on any of the links in the author profile.
