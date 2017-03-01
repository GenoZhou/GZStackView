# StackViewController

UIKit has UITableViewController for UITableView, as well as having UICollectionViewController for UICollectionView.

So why not having a UIStackViewController for UIStackView?

## Overview

This frameworks offers 2 main classes: **StackViewController** and **AutoScrollView**.

**StackViewController** class implements a specialized view controller that manages a stack view and an auto scroll view. Any subclass of UIView and UIView can be added as StackViewItem through public apis. This class will be reponsible of maintaining a StackViewItem array as context. This class also provides some additional features like:

- **Scrolling Support**

  Make stack view scrollable based on its axis.

- **Autoscroll Support**

  Automatically adjust scroll view content inset and scroll to first responder when keyboard appears.

- **Configurable StackView**

  The stack view can be easily configured through a property.

- **Customizable Seperator**

  Can be toggled for individual stack item. Can be customized by registering custom seperator view class.

#### Symbols

- **var configuration: ((UIStackView) -> Void)?**

  Optional property to configure stack view (axis, aligment, distribution, spacing, etc;). 

- **var backgroundColor: UIColor?**

  Optional property to set background color. The default value is white.

- **var seperatorClass: StackViewItemSeperator.Type?**

  The property to set the class type of seperator view. Custom class can be used as long as it conforms to StackViewItemSeperator protocol. This property is required if seperator is required.

- **func addItem(_ item: StackViewItem, hideSeperator: Bool)**

- **func addItem(_ item: StackViewItem)**

- **func addItems(_ items: [StackViewItem], hideSeperator: Bool)**

- **func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeperator: Bool)**

- **func insertItem(_ item: StackViewItem, atIndex index: Int)**

- **func insertItems(_ items: [StackViewItem], fromIndex index: Int, hideSeperator: Bool = false)**

- **func removeItem( atIndex index: Int)**

- **func removeItem(_ item: StackViewItem)**

- **func removeItems(_ items: [StackViewItem])**


**AutoScrollView** is a subclass of UIScrollView. 

<Under Construction….>

#### Symbols

- **isAutoScrollEnabled: Bool**

  A property to set if auto scroll feature is enabled.

- **func addManagedSubview(_ view: UIView)**

- **func removeManagedSubview(_ view: UIView)**

## Example

An example project available under /Example, better one coming soon!

## About this project

This project is inspired by [seedco/StackViewController](https://github.com/seedco/StackViewController). The concepts are brilliant but implementation is a bit complicated for Geno, so he ended up mimicing and crafting his own.

### Todo:

- [x] Background color support
- [x] Autoscroll support
- [ ] Carthage/Cocoapods support
- [ ] A **better** example
- [ ] Unit Tests
- [ ] CICD

## License

This project is licensed under the MIT license. See LICENSE.md for more details.
