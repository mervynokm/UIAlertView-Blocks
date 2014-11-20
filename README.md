# UIAlertView + Blocks.h
Copyright (c) 2014 Mervyn Ong. All rights reserved.

Simply put, this is a block-based soluation for UIAlertView to avoid the need of using a delegate

### How to use it
Add UIAlertView+Blocks into your project and import the necessary header file 

```sh
#import "UIAlertView+Blocks.h"
```

Additional properties and methods available are as follows:

Properties:
```
@property (nonatomic, copy) CompletionBlock completionBlock;
@property (nonatomic, copy) AlertBlock willPresentBlock;
@property (nonatomic, copy) AlertBlock didPresentBlock;
@property (nonatomic, copy) CompletionBlock willDismissBlock;
@property (nonatomic, copy) CompletionBlock didDismissBlock;
```

Public Class Methods:
```
+(instancetype)showAlertViewWithCompletion:(CompletionBlock)completionBlock
                                  forTitle:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                         otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
```
Have fun!
### Version
1.0
