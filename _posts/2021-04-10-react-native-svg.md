---
title: React-Native SVG Example
date: 2021-04-10
modified: 2021-04-22
categories: [react-native]
tags: [react-native, svg, vector, icon]
excerpt: Working with SVGs in React-Native
classes: wide
header:
  overlay_image: /assets/images/posts/react-native-svg/header.jpg
  overlay_filter: 0.5 # same as adding an opacity of 0.5 to a black background
  caption: "Photo by [Harpal Singh](https://unsplash.com/@aquatium) on [Unsplash](https://unsplash.com)"
---

## Series Intro

Welcome to the first post of my React Native series! Each article in the series will dive into a different aspect of the framework. Let's go!

## Getting Started

To begin we'll need a React Native application to add SVGs to. I started a new one in my [examples repo](https://gitlab.com/stephen.cavender/react-native-examples){:target="\_blank"} under `svg` with the `npx react-native init PROJECTNAME` command. An existing app will work as well but we'll have to check version compatibility. Our next step is to fire up the app. I run `npm run start` which just calls `react-native start`. Now metro is running in this terminal and we need to open a new terminal. In the new terminal let's fire up the app in either iOS or Android. I started with Android so I ran `npm run android` which just runs `react-native run-android`. Now we have an Android emulator running our app! Here's a screenshot of where we're at on Android:

![Initial Screen](/assets/images/posts/react-native-svg/init.png "Initial Screen"){:width="200px"}
{: style="text-align: center;"}

## Drawing SVGs

React Native doesn't support SVG out of the box. So we'll have to install a package to handle SVGs for us. I chose [svg-react-native](https://github.com/react-native-svg/react-native-svg). Here's where we need to pay attention to the versions we're on. There are various steps to getting this package to work in the app depending on the versions it has. Be sure to read through the Readme and the [table of versions](https://github.com/react-native-svg/react-native-svg#notice). Since I'm on a brand new app I ran `npm i react-native-svg` to install the latest. Now with the package installed we can import it and start drawing SVGs in our app! I added a separate component to contain my SVG: `/components/svg.js`. Here's my component code:

```
import React from 'react';
import type {Node} from 'react';
import Svg, {Circle, Rect, Path} from 'react-native-svg';
import {View} from 'react-native';

const SvgComp = (): Node => {
  return (
    <View>
      <Svg height="100" width="100">
        <Rect x="0" y="0" width="100" height="100" fill="black" />
        <Circle cx="50" cy="50" r="30" fill="yellow" />
        <Circle cx="40" cy="40" r="4" fill="black" />
        <Circle cx="60" cy="40" r="4" fill="black" />
        <Path d="M 40 60 A 10 10 0 0 0 60 60" stroke="black" />
      </Svg>
    </View>
  );
};

export default SvgComp;
```

And here's a screenshot of how it renders in the Android emulator:

![SVG Drawing](/assets/images/posts/react-native-svg/drawing.png "SVG Drawing"){:width="200px"}
{: style="text-align: center;"}

---

**NOTE**

I had to restart metro and re-run the android command to get SVGs working.

---

Check out the [supported elements](https://github.com/react-native-svg/react-native-svg#supported-elements) to see what else we can do with SVGs now.

## Using SVG Files

Maybe we have some SVG files we want to include rather than drawing them. For this case we'll need another package. [Kristerkari](https://github.com/kristerkari) has us covered with [react-native-svg-transformer](https://github.com/kristerkari/react-native-svg-transformer). Install the package with `npm i --save-dev react-native-svg-transformer`. Next we'll update our metro config to handle transforming SVGs. Here's what my metro.config.js looks like now:

```
const {getDefaultConfig} = require('metro-config');

module.exports = (async () => {
  const {
    resolver: {sourceExts, assetExts},
  } = await getDefaultConfig();
  return {
    transformer: {
      getTransformOptions: async () => ({
        transform: {
          experimentalImportSupport: false,
          inlineRequires: true,
        },
      }),
      babelTransformerPath: require.resolve('react-native-svg-transformer'),
    },
    resolver: {
      assetExts: assetExts.filter(ext => ext !== 'svg'),
      sourceExts: [...sourceExts, 'svg'],
    },
  };
})();
```

I needed some SVG files so I grabbed these:

- A colorized one: [firefox.svg](https://raw.githubusercontent.com/kristerkari/react-native-svg-example/master/logos/firefox.svg) from Kristerkari's [example repo](https://github.com/kristerkari/react-native-svg-example)
- And a customizable one: [coffee.svg](https://feathericons.com/?query=coffee) from Feather

And another new component for SVG files: `./components/svg-files.js`. Here's the component code:

```
import React from 'react';
import type {Node} from 'react';
import {View} from 'react-native';
import Coffee from '../assets/icons/coffee.svg';
import Firefox from '../assets/icons/firefox.svg';

const SvgFilesComp = (): Node => {
  return (
    <View>
      <Firefox />
      <Coffee />
    </View>
  );
};

export default SvgFilesComp;
```

And here's a screenshot of how it renders in the Android emulator:

![SVG File Initial Screen](/assets/images/posts/react-native-svg/file-1.png "SVG File Initial Screen"){:width="200px"}
{: style="text-align: center;"}

---

**NOTE**

I had to restart metro and re-run the android command to get SVGs working.

---

Notice that our coffee SVG isn't visible but taking space. That's because its designed to be customizable. We need to pass in some arguments if we want it to render in color. Which arguments and whether it's customizable at all depends on the SVG.

For instance, both SVGs I chose have widths and heights set for them. If we don't include those properties then their defaults are used. If we pass in a width to the firefox SVG check out what happens:

```
<Firefox width={50} />
<Coffee />
```

![SVG File Firefox Width](/assets/images/posts/react-native-svg/file-2.png "SVG File Firefox Width"){:width="200px"}
{: style="text-align: center;"}

The image is the correct size but the overall SVG is still taking up a lot more room than it needs. We have to pass in both sizes to fix this. While we're at it, let's give some color to our coffee icon by passing in a fill color.

```
<Firefox width={50} height={50} />
<Coffee fill={'blue'} />
```

![SVG File Firefox Size Coffee Fill](/assets/images/posts/react-native-svg/file-3.png "SVG File Firefox Size Coffee Fill"){:width="200px"}
{: style="text-align: center;"}

Now our firefox looks good but our coffee icon does not. This particular icon isn't meant to have a fill. Rather, we should pass in a stroke to get the desired look.

```
<Firefox width={50} height={50} />
<Coffee stroke={'#333'} />
```

![SVG File Final](/assets/images/posts/react-native-svg/file-4.png "SVG File Final"){:width="200px"}
{: style="text-align: center;"}

## Using an SVG Font

Now let's pull in an SVG font with a bunch of icons we can use. I chose a set of open source icons called [Feather](https://feathericons.com/). Install Feather with `npm i feather-icons` and grab an SVG file. I created another separate component to try out Feather icons in my example app: `/components/feather.js`. Here's my component code:

```
import React from 'react';
import type {Node} from 'react';
import {View} from 'react-native';
import ArrowUpCircle from 'feather-icons/dist/icons/arrow-up-circle.svg';

const FeatherComp = (): Node => {
  return (
    <View>
      <ArrowUpCircle stroke="red" fill="#fff" width={32} height={32} />
    </View>
  );
};

export default FeatherComp;
```

And here's a screenshot of how it renders in the Android emulator:

![Feather Icon](/assets/images/posts/react-native-svg/feather-1.png "Feather Icon"){:width="200px"}
{: style="text-align: center;"}

This is great because now we have access to all of the Feather icons as React components. But what if we had an SVG file we wanted to use?

Now those are some good looking SVGs in a React Native app!

## Conclusion

In this article we covered how to include SVGs inside a React Native application using three different methods:

1. Drawing them
2. Importing an SVG font
3. Loading from .svg files

Thanks for reading! Please share using any of the buttons below and stay tuned for more of my React Native series of posts. Don't hesitate to reach out in the comments below or on any of the links in the author profile.
