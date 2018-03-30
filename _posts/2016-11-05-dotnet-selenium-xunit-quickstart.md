---
title: .NET Core Selenium Xunit QuickStart Guide
modified: 2016-11-05
categories: [Selenium]
excerpt: A quick how-to on setting up a solution using Xunit and Selenium!
tags: [Selenium, MSTest, dotnetcore]
published: false
---

## Getting started with .NET Core, Selenium and Xunit!
In this article we'll be using Xunit and Selenium to write tests for web applications. This will be a starter project we can build on for various projects and in future articles.

### Requirements
Here are the requirements before we get started:

* [Visual Studio](https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx) (A Microsoft Integrated Development Environment or IDE)
* [Selenium C# language bindings](http://docs.seleniumhq.org/download/) (But we'll let VS pull these in)
* [xUnit.net](https://xunit.github.io) (But we'll let VS pull this in)
* Any browsers installed that you want to test [Supported Platforms](http://docs.seleniumhq.org/about/platforms.jsp)

### Selenium Prep
If you haven't read through my quick [Overview of Selenium]({{ site.url }}{{ site.baseurl }}/selenium/selenium-overview-setup) you should do that now. Selenium will need a few things configured before it'll do its magic!

### Create Project
To kick things off we'll need a new project.

**File > New > Project**

![Create a new project]({{ site.url }}{{ site.baseurl }}/assets/images/dotnet-selenium-mstest/new-project.png "Create a new project")
Select the Class Library (.NET Core) template (**Templates > Visual C# > .NET Core**) and give it a name. Press Ok to create the project. Visual Studio will create the project and open up your first UnitTest class.
![New project's first view]({{ site.url }}{{ site.baseurl }}/assets/images/dotnetcore-selenium-xunit/new-project-first-view.png "New project's first view")

### Update project.json
Now we'll need to have the project pull in Selenium and xUnit. To do that we just need to include them as dependencies in the project.json file. Replace the contents of the project.json file with these:

```
{
"version": "1.0.0-*",
"testRunner": "xunit",
"dependencies": {
"xunit": "2.2.0-beta2-build3300",
"dotnet-test-xunit": "2.2.0-preview2-build1029",
"Selenium.WebDriver": "3.0.0"
},
"frameworks": {
"netcoreapp1.0": {
"dependencies": {
"Microsoft.NETCore.App": {
"type": "platform",
"version": "1.0.1"
}
}
},
"net451": {
"dependencies": {
"Microsoft.NETCore.Platforms": "1.0.1"
}
}
}
}
```
Once the references have been pulled in and there are no errors we're ready to write our test!

### Write Test
Now the fun begins; we can write the first Selenium test!
We'll write our test against [The Internet](http://the-internet.herokuapp.com/)[^theinternet].

[^theinternet]: Credit to [Dave Haeffner](http://davehaeffner.com/).

Select Class1 and remove the Class1 method. Replace it with:

```c#
[Fact]
public void Test1()
{
//var driver = new OpenQA.Selenium.Firefox.FirefoxDriver
//var driver = new OpenQA.Selenium.Edge.EdgeDriver
//var driver = new OpenQA.Selenium.IE.InternetExplorerDriver
var driver = new OpenQA.Selenium.Chrome.ChromeDriver
{
Url = "http://the-internet.herokuapp.com/"
};
Assert.Equal(driver.Title == "The Internet");
driver.Dispose();
}
```

1. Get a web driver
2. Set the URL property (tells the driver to go to that URL)
3. Assert on the title of the driver
4. Dispose of the driver

### Run Test
Now that we have a functional test we can run it. First, if the Test Explorer isn't displayed we need to add it.

**Test > Windows > Test Explorer**

Our test isn't showing up yet. We need to build the solution for it to recognize that we've written a test it can run. Right click on the solution in the Solution Explorer and Build or Rebuild the solution. If the build is successful we should see our test show up in the Test Explorer. Now we can right click on our test and tell it to run. If all went according to plan we should see a Chrome window pop up, navigate to Google's home page and then close.

This is a basic, and brittle, example of how Selenium works. If our assertion returns false the test will report a failure but the browser window will still be alive. This test is brittle in that it can't run any code after the Assert if the Assert returns false. We'll cover a much better testing approach in a later post to avoid such things! This is not an example of best practices by any means. This is to get you a working example of Selenium. Stay tuned for more posts on how to use Selenium, best practices for automating tests and video tutorials!

Repo: [selenium-dotnetcore-xunit](https://github.com/StephenCavender/selenium-dotnetcore-xunit)

Thanks for reading! Be sure to share this post if you found it helpful and don't hesitate to chat with me about it!
