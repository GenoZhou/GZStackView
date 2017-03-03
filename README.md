# StackViewController

[![Build Status](https://travis-ci.org/GenoZhou/StackViewController.svg?branch=master)](https://travis-ci.org/GenoZhou/StackViewController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/genozhou/stackviewcontroller)

UIKit has UITableViewController for UITableView, as well as having UICollectionViewController for UICollectionView.

So why not having a UIStackViewController for UIStackView?

## Overview

The key components of this framework are **AutoScrollView** class, **StackViewContainer** protocol, and **StackViewItem** protocol.

**AutoScrollView** subclasses UIView and add autoscrolling feature by observing keyboard and first responder. 

**StackViewContainer** sets the requirements of creating a fully featured UIStackView wrapper and provides various extensions to add/remove items while keeping everything managed internally in between auto scroll view and stack view. As an example, **SimpleStackViewController** class is included that implements the protocol to get features like autoscrolling for stack view, separator customization, background color property, etc;.

**StackViewItem** offers a unified interface that enables StackViewContainer to add/remove both views and view controllers and keep references of added items on track.

In addition, a uiview subclass **BaseSeparatorView** conforming **StackViewItemSeparator** protocol is available and being used as default separator in **SimpleStackViewController** class.

## Installation

For **Carthage**:

1. Add following to the end of your Cartfile:

   ```
   github "GenoZhou/StackViewController" ~> 1.0
   ```

2. Include following in Build Phases as instructed in [Carthage Doc](https://github.com/Carthage/Carthage):

   ```
   $(SRCROOT)/Carthage/Build/iOS/StackViewController.framework
   ```

3. Run `carthage update` as usual.

For **Cocoapods**:

1. Include following in your Podfile:

   ```
   pod 'GZStackViewController', '~> 1.0'
   ```

2. Run `pod install` as usual.

For **Swift Hipster**: 

Drag and Drop ? Whatever you want :)

## How to use

There are different ways to take advantages of this framework.

You can just grab SimpleStackViewController, initiate an instance, or subclass from it to make magic work as long as it is good enough to cover your need.

An individual project 'Example' is included that demonstrates the approach of initiating SimpleStackViewController instance and adding it as child controller.

However, I **highly recommend** you to create your own view controller class that conforms to StackViewContainer protocol. 

SimpleStackViewController is literally a good example that injects a pack of great features without defining any method.

## About this project

This project is inspired by [seedco/StackViewController](https://github.com/seedco/StackViewController). The concepts are brilliant but implementation seems too complicated for Geno, so Geno ended up crafting his own.

### Todo:

- [x] Background color support
- [x] Autoscroll support
- [x] Carthage/Cocoapods support
- [ ] A **better** example
- [ ] Unit Tests
- [x] CICD

## License

This project is licensed under the MIT license. See LICENSE.md for more details.
