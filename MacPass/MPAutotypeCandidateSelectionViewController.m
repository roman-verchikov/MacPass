//
//  MPAutotypeCandidateSelectionViewController.m
//  MacPass
//
//  Created by Michael Starke on 26.10.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
#import "MPAutotypeCandidateSelectionViewController.h"
#import "MPAutotypeContext.h"
#import "MPAutotypeDaemon.h"

#import "KPKNode+IconImage.h"

#import <KeePassKit/KeePassKit.h>

@interface MPAutotypeCandidateSelectionViewController () <NSTableViewDataSource, NSTableViewDelegate>
@property (weak) IBOutlet NSButton *selectAutotypeContextButton;
@property (weak) IBOutlet NSTableView *contextTableView;

@end

@implementation MPAutotypeCandidateSelectionViewController

- (NSString *)nibName {
  return @"AutotypeCandidateSelectionView";
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.selectAutotypeContextButton.enabled = NO;
}

#pragma mark NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return self.candidates.count;
}

#pragma mark NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  NSTableCellView *view = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
  MPAutotypeContext *context = self.candidates[row];
  NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", context.entry.title, context.maskedEvaluatedCommand]];
  [string setAttributes:@{NSForegroundColorAttributeName: NSColor.disabledControlTextColor} range:NSMakeRange(context.entry.title.length + 1, context.maskedEvaluatedCommand.length)];
  view.textField.attributedStringValue = string;
  view.imageView.image = context.entry.iconImage;
  return view;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
  NSTableView *tableView = notification.object;
  if(tableView != self.contextTableView) {
    return;
  }
  self.selectAutotypeContextButton.enabled = (self.contextTableView.selectedRow != -1);
}

#pragma mark Actions
- (void)selectAutotypeContext:(id)sender {
  NSInteger selectedRow = self.contextTableView.selectedRow;
  if(selectedRow >= 0 && selectedRow < self.candidates.count) {
    [[MPAutotypeDaemon defaultDaemon] selectAutotypeCandiate:self.candidates[selectedRow]];
  }
  else {
    [self cancelSelection:sender]; // cancel since the selection was invalid!
  }
}

- (void)cancelSelection:(id)sender {
  [[MPAutotypeDaemon defaultDaemon] cancelAutotypeCandidateSelection];
}


@end
