# GZStackView

[![Build Status](https://travis-ci.org/GenoZhou/GZStackView.svg?branch=master)](https://travis-ci.org/GenoZhou/GZStackView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/genozhou/stackviewcontroller)

UIKit has UITableViewController for UITableView, as well as having UICollectionViewController for UICollectionView.

So why not having a UIStackViewController for UIStackView?

## Overview

### [DEPRECATED]

### This repo is no longer maintained, please go checkout my new approach [GZForm](https://github.com/GenoZhou/GZForm).

3 key components of this framework are **AutoScrollView** class, **StackViewContainer** protocol, and **StackViewItem** protocol.

**AutoScrollView** subclasses UIView and add autoscrolling feature by observing keyboard and first responder.

**StackViewContainer** sets the requirements of creating a fully featured UIStackView wrapper and provides various extensions to add/remove items while keeping everything managed internally in between auto scroll view and stack view.

As an example, **BaseStackViewController** class is included that implements the protocol to get features like autoscrolling for stack view, separator customization, background color property, etc;.

**StackViewItem** offers a unified interface that enables StackViewContainer to add/remove both views and view controllers and keep references of added items on track.

In addition, a uiview subclass **BaseSeparatorView** conforming **StackViewItemSeparator** protocol is available and being used as default separator in **BaseStackViewController** class.

## Installation

Carthage:

```
// Cartfile
github "GenoZhou/GZStackView" ~> 1.0

// Build Phases
$(SRCROOT)/Carthage/Build/iOS/GZStackView.framework

// Run
carthage update
```
Cocoapods:

```
// Podfile
pod 'GZStackView', '~> 1.0'

// Run
pod install
```
## How to use

There are different ways to take advantages of this framework.

You can just grab BaseStackViewController, initiate an instance, or subclass from it to make magic work as long as it is good enough to cover your need.

An individual project 'Example' is included that demonstrates the approach of initiating BaseStackViewController instance and adding it as child controller.

However, I **highly recommend** you to create your own view controller class that conforms to StackViewContainer protocol.

BaseStackViewController is literally a good example that injects a pack of great features without defining any method.

## About this project

This project is inspired by [seedco/StackViewController](https://github.com/seedco/StackViewController). The concepts are brilliant but implementation seems too complicated for Geno, so Geno ended up crafting his own.

### Todo:

- [ ] Add CHANGELOG
- [ ] Animation
- [ ] Add discussion about why uistackview and when uitableview
- [ ] Add instruction of using this framework with interface builder

## License

This project is licensed under the MIT license. See LICENSE.md for more details.
