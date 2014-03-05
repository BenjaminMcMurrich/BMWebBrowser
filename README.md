BMWebBrowser
============

Embedded Web Browser like in the Twitter and Facebook iOS Apps

[![Alt][screenshot1_thumb]][screenshot1] [![Alt][screenshot2_thumb]][screenshot2] [![Alt][screenshot3_thumb]][screenshot3]
[screenshot1_thumb]: http://mcmurrich.fr/products/bmwebbrowser/screen1_thumb.png
[screenshot1]: http://mcmurrich.fr/products/bmwebbrowser/screen1.png
[screenshot2_thumb]: http://mcmurrich.fr/products/bmwebbrowser/screen2_thumb.png
[screenshot2]: http://mcmurrich.fr/products/bmwebbrowser/screen2.png
[screenshot3_thumb]: http://mcmurrich.fr/products/bmwebbrowser/screen3_thumb.png
[screenshot3]: http://mcmurrich.fr/products/bmwebbrowser/screen3.png

## Features

BMWebBrowser offers the following **features**:

* Back and forward buttons (*only appear when it's needed*)
* Progress view animation while page is loading
* Action button to open the current page in Safari or share the link on social networks
* Displays the page title at the navigation bar
* Displays the current URL in the navigation bar
* Customizable colors on URL Label in the navigation bar
* Customizable tint color on progress view

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like BMWebBrowser in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod "BMWebBrowser", "~> 0.2"
```

## Usage

####  Push in Navigation Controller
```objective-c
NSURL * URL = [NSURL URLWithString:@"http://www.google.com"];
[self.navigationController pushViewController:[BMWebBrowser viewControllerWithURL:URL] animated:YES];
```

####  Display as a Modal ViewController
```objective-c
NSURL * URL = [NSURL URLWithString:@"http://www.google.com"];
[self presentViewController:[BMWebBrowser modalViewControllerWithURL:URL] animated:YES completion:nil];
```


## Customization
BMWebBrowser include the [MZAppearance](https://github.com/m1entus/MZAppearance) proxy for custom objects.
 
You can set the color of the label that display the link in the navigation bar with:

```objective-c
[[BMWebBrowser appearance] setUrlLabelTextColor:[UIColor grayColor]];
```

Or set the progress view tint color with:

```objective-c
[[BMWebBrowser appearance] setProgressViewTintColor:[UIColor redColor]];
```


TO-DO
--
- Add more customization properties
- Add localization files

## Licence

Copyright (c) 2014 Benjamin McMurrich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.