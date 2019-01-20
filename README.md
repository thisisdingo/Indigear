# Indigear
![MIT License](https://img.shields.io/badge/license-MIT-brightgreen.svg) [![Swift 4.2](http://img.shields.io/badge/swift-4.1-brightgreen.svg)](https://swift.org/)

Indigear is simple library for working with HTTP(s) connections

### Installation

Indigear requires [CocoaPods](https://cocoapods.org/).

Installing.

```
platform :ios, '9.0'
use_frameworks!

pod 'Indigear'
```

### Usage

Making simple GET request

```swift
import Indigear

/* YOUR AWESOME CODE */

Indigear.run("http://google.com") { result in
            if result.isSuccess {
                print("Fetched data:", String(data: result.result!, encoding: .utf8))
            }else{
                print("Error:", result.error!.localizedDescription)
            }
        }
```

Making more complex requests.

```swift
        import Indigear
        
        /* YOUR AWESOME CODE */

        let header : IndigearHeader = ["User-Agent" : "Your Awesome Application"]
        let params = ["param1" : "value1"]
        
        let requestURL = "http://indigear.michil.ru/index.php" + "?getparam1=value1&getparam=value2"
        
        Indigear.run(requestURL, method: .post, headers: header, body: params) { result in
            if result.isSuccess {
                do {
                    let result = try JSONSerialization.jsonObject(with: result.result!, options: []) as! [String : Any]
                    
                    print("Request POST parameters: ", result["POST"] ?? "")
                    print("Request GET parameters: ", result["GET"] ?? "")
                    print("Request HEADERS: ", result["HEADERS"] ?? "")
                    
                } catch {
                    print(error)
                }
                
            }else{
                print("Error: ", result.error!.localizedDescription)
            }
        }
```

### Author
Michil Khabarov - http://michil.ru

### LICENSE
Indigear is available under the MIT license. See the LICENSE file for more info.

