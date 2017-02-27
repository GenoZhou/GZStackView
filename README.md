# StackViewController

UIKit has UITableViewController for UITableView, as well as having UICollectionViewController for UICollectionView.

So why not having a UIStackViewController for UIStackView?

## Overview

This frameworks cotains 3 main components: **StackViewController** class. **StackViewItem** protocol, and **StackViewSeperatorType** protocol.

### StackViewController

This class implements a specialized view controller thats manages a stack view. Internally, it holds an array of **StackViewItem** as the context of its stack view. This class also provideds additional features like:

- Scrolling Support
- Customizable StackView
- Customizable SeperatorView
- ViewController Containment

#### Symbols

**var configuration: ((UIStackView) -> Void)?**

Optional property to configure stack view (axis, aligment, distribution, spacing, etc;) before stack view controller get loaded.

**public var seperatorClass: StackViewSeperatorType.Type?**

The property to set the class type of seperator view. Custom class can be used as long as it conforms to StackViewSeperatorType protocol. This property is required if seperator is required.

**func addItem(_ item: StackViewItem, hideSeperator: Bool)**

**func addItem(_ item: StackViewItem)**

**func removeItem(_ item: StackViewItem)**

Public methods to manage the content of stack view controller. Any UIView subclass and UIViewController subclasses can be passed in as item. Custom classes can also be used as long as they conform to StackViewItem protocol. Seperator is displayed by default, but will not show anything if seperatorClass property is not set.

**func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeperator: Bool)**

**func insertItem(_ item: StackViewItem, atIndex index: Int)**

**func removeItem( atIndex index: Int)**

Same as above, but with index.

**func addItems(_ items: [StackViewItem], hideSeperator: Bool)**

**func removeItems(_ items: [StackViewItem])**

Plural version of methods listed above.

### StackViewItem

UIView and UIViewController classes are extended by this protocol in this framework . You can also make your own class and make it conform to this protocol.

### StackViewSeperatorType

The framework offers a simple 1px seperator view class that conforms to this protocol. You can use that seperator by setting **seperatorClass** property of your stack view controller. You can use your own class and make it conform to this protocol.

## Example

An example project available under /Example, better one coming soon!

## About this project

This project is inspired by [seedco/StackViewController](https://github.com/seedco/StackViewController). The concepts are brilliant but implementation is a bit complicated for Geno, so he ended up mimicing and crafting his own.

### Todo:

- [ ] Autoscroll support
- [ ] Carthage/Cocoapods support
- [ ] A **better** example
- [ ] Unit Tests
- [ ] CICD

## License

This project is licensed under the MIT license. See LICENSE.md for more details.
