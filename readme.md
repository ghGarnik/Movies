# Movies
================

# Description

This is a iOS app that consumes and presents movie list / detail from [TheMovieDatabase](https://www.themoviedb.org/), using reactive programming.

## Requirements

- iOS 13.0+
- Swift 5.1
- Xcode 11.0

## Installation

- Clone the repo.
- Install CocoaPods Keys
```
$ gem install cocoapods-keys
```
- Set your Themoviedb api key
```
$ pod keys set api Key {your_api_key}
$ pod install
```
- Open `Movies.xcodeproj` and run the app.

## Tools/Libraries/SDKs used
[CocoaPods](https://cocoapods.org/)

|Dependency | Task |
| ---------------------------------- | ------------------------ |
|[Keys](https://github.com/orta/cocoapods-keys) | Api Key management |
|[Kingfisher](https://github.com/onevcat/Kingfisher/) | Async images loading |
|[RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) |Networking, HTTP requests. Response mapping|
|[RxCocoa](https://github.com/ReactiveX/RxSwift/tree/main/RxCocoa)| UIKit Rx bindings |
|[RxSwift](https://github.com/ReactiveX/RxSwift)| Reactive programming |

# Development requirements

* MVVM or VIPER architecture (avoid MVC).
* UI Implementation should be done avoiding Storyboards and XIBs.
* Implement reactive programming for bindings.

# Implementation

### Organization
The project code is arranged by conceptual layers as follows.

| Name                               | Description              |
| ---------------------------------- | ------------------------ |
|Extensions | Groups all extensions. |
|Networking | This layer manages HTTP communications. Uses RxAlamofire for requests, and directly decode response into Codable objects. |
| Modules |Modules that include UI presented to the user. It is composed of the required secreens of the application, their presentation logic, and repositories|
| \|-> Coordinator |In charge of instantiating ViewControllers, dependency injection and navigation flow. |
| \|-> Module: Domain |Domain data. Conforming to Codable to reuse them for network reponse decoding, to avoid extra codebase. |
| \|-> Module: Data |Data sources, including Repository and services for the current module. |
| \|-> Module: Presentation |Includes a ViewModel that obtains data from Repository and makes included ViewController to present it |

### Code explanation

The main architecture approach is `MVVM + Coordinator`. In project files organization terms, Model is in Domain folder, View as ViewController and ViewModel in Presentation folder for each UI related module.

`Coordinator` creates a NavigationController to manage the app navigation flow, hence navigation related events are managed there. It is in charge of ViewControllers instatiation, creating and injecting required dependencies. Keeps each View module agnostic from others.

`ViewModel`s in each module are in charge of properly bind ViewController data requirements to repository dependency, and manage the data flow.

All `Views`s are created programmatically. Constraints are set using strictly `Visual Format Language`. Indeed, pure AutoLayout with NSLayoutConstraints, or other 3rd party kits like SnapKit could have been implemented. This implementation is arbitrary.

Each module has it's `Repository` in charge of obtaining data from it's module remote service. In fact, in this case, `Repository` and `Service` could have been merged into one single layer, as there is just one service and no local storage available, so data is always being fetched from `Service`.

`Service` layer is in charge of creating / preparing requests, including parameters and endpoints, and then make the request to `APIClient` dependency.

There is a common `APIClient` where all modules requests are driven. It has a generic request function and maps the response object to the infered type.

Required API Key is injected among `CocoaPods Keys`. This makes possible the sensible key not to be stored in the repository but in the local machine, and it doesn't appear in the code per se. Furthermore, if this app would be in a CI system, different keys for different environments could be set easily.

## Author
Garnik Harutyunyan Lapushnyan
[ghgarnik (AT) gmail.com]()

## License
(The MIT License)

Copyright (c) 2020 Garnik Harutyunyan Lapushnyan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.