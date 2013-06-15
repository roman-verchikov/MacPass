//
//  MPMainWindowController.h
//  MacPass
//
//  Created by Michael Starke on 24.07.12.
//  Copyright (c) 2012 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MPViewController;
@class MPEntryViewController;
@class MPInspectorViewController;
@class MPPasswordEditViewController;
@class MPPasswordInputController;
@class MPOutlineViewController;
@class MPCreationViewController;


@interface MPDocumentWindowController : NSWindowController <NSWindowDelegate>

@property (readonly, retain) MPPasswordInputController *passwordInputController;
@property (readonly, retain) MPPasswordEditViewController *passwordEditController;
@property (readonly, retain) MPEntryViewController *entryViewController;
@property (readonly, retain) MPOutlineViewController *outlineViewController;
@property (readonly, retain) MPInspectorViewController *inspectorViewController;
@property (readonly, retain) MPCreationViewController *creationViewController;


- (void)showEntries;
- (void)showPasswordInput;
- (void)performFindPanelAction:(id)sender;
- (void)clearOutlineSelection:(id)sender;
- (IBAction)editPassword:(id)sender;
- (void)lock:(id)sender;

- (void)createGroup:(id)sender;
- (void)toggleInspector:(id)sender;

@end