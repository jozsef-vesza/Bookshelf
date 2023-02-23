# Bookshelf

Minimal example app to demo a the techniques below.

## Struct-based dependencies 
Inspired by Pointfree's course on [Designing Dependencies](https://www.pointfree.co/collections/dependencies/designing-dependencies) I've decided to move away from a protocol-oriented approach for dependencies, and exposed a simple struct instead.
* separating interface and implementation can help a lot with build times in larger projects
* the approach results in less boilerplate, and provides straightforward inline mocking

## Enum-based networking
This approach is based on [Moya's implementation](https://github.com/Moya/Moya).
* enums are a good way to represent a finite number of endpoints
* the requirements of declaring a remote API are made clear via protocols.

## Unit-testing networking code
Instead of wrapping Foundation components in protocols, I've decided to rely on `URLProtocol` to provide mock responses (based on this [article](https://www.hackingwithswift.com/articles/153/how-to-test-ios-networking-code-the-easy-way))

# Screenshots

<img src="https://user-images.githubusercontent.com/2749464/220887099-6a06b364-03e4-4636-8a14-9ccf20fdff68.png" height="600" />
