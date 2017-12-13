# Networking101
[![IDE](https://img.shields.io/badge/Xcode-9-blue.svg)](https://developer.apple.com/xcode/)
[![Language](https://img.shields.io/badge/swift-4-blue.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2011-blue.svg)](https://developer.apple.com/ios/)


## Networking with URLSessions

REST, HTTP, JSON — What’s that?


## JSON
JSON stands for JavaScript Object Notation; it provides a straightforward, human-readable and portable mechanism for transporting data between two systems. JSON has a limited number of data types: string, boolean, array, object/dictionary, null and number; there’s no distinction between integers and decimals. Apple supplies the JSONSerialization class to help convert your objects in memory to JSON and vice-versa.

The combination of HTTP, REST and JSON make up a good portion of the web services available to you as a developer. Trying to understand how every little piece works can be overwhelming. Libraries like Alamofire can help reduce the complexity of working with these services — and get you up and running faster than you could without its help.

-----

## HTTP
HTTP is the application protocol, or set of rules, web sites use to transfer data from the web server to your screen. You’ve seen HTTP (or HTTPS) listed in the front of every URL you type into a web browser. You might have heard of other application protocols, such as FTP, Telnet, and SSH. HTTP defines several request methods, or verbs, the client (your web browser or app) use to indicate the desired action:

HTTP request methods:

- GET: Used to retrieve data, such as a web page, but doesn’t alter any data on the server.

- HEAD: Identical to GET but only sends back the headers and none of the actual data.

- POST: Used to send data to the server, commonly used when filling a form and clicking submit.

- PUT: Used to send data to the specific location provided.

- DELETE: Deletes data from the specific location provided.

------

## REST
REST, or REpresentational State Transfer, is a set of rules for designing consistent, easy-to-use and maintainable web APIs. REST has several architecture rules that enforce things such as not persisting states across requests, making requests cacheable, and providing uniform interfaces. This makes it easy for app developers like you to integrate the API into your app — without needing to track the state of data across requests.


