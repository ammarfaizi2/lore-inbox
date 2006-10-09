Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWJIHaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWJIHaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWJIHaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:30:35 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:4050 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932202AbWJIHae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:30:34 -0400
Message-Id: <6.1.1.1.2.20061009092219.02b0bec0@192.168.6.12>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 09 Oct 2006 09:30:06 +0200
To: linux-kernel@vger.kernel.org
From: Roger While <simrw@sim-basis.de>
Subject: menuconfig bust in 2.6.19rc1-git5
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-SIMBasis-MailScanner-Information: Please contact the ISP for more information
X-SIMBasis-MailScanner: Found to be clean
X-SIMBasis-MailScanner-From: simrw@sim-basis.de
X-ID: ZBqYK0ZYwekcJmBAZ+VnWsykiA8tMHS9v04yWu8cfjVY6kok6-MiQR@t-dialin.net
X-TOI-MSGID: 74c8580d-aa7f-44d9-bcd8-d1272c2a4683
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > make menuconfig
HOSTCC  scripts/basic/fixdep
HOSTCC  scripts/basic/docproc
HOSTCC  scripts/kconfig/conf.o
HOSTCC  scripts/kconfig/kxgettext.o
HOSTCC  scripts/kconfig/lxdialog/checklist.o
In file included from scripts/kconfig/lxdialog/checklist.c:24:
scripts/kconfig/lxdialog/dialog.h:96: error: syntax error before "chtype"
scripts/kconfig/lxdialog/dialog.h:96: warning: no semicolon at end of 
struct or union
scripts/kconfig/lxdialog/dialog.h:100: error: syntax error before '}' token
scripts/kconfig/lxdialog/dialog.h:104: error: field `screen' has incomplete 
type
scripts/kconfig/lxdialog/dialog.h:105: error: field `shadow' has incomplete 
type
scripts/kconfig/lxdialog/dialog.h:106: error: field `dialog' has incomplete 
type
scripts/kconfig/lxdialog/dialog.h:107: error: field `title' has incomplete type
scripts/kconfig/lxdialog/dialog.h:108: error: field `border' has incomplete 
type
scripts/kconfig/lxdialog/dialog.h:109: error: field `button_active' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:110: error: field `button_inactive' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:111: error: field `button_key_active' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:112: error: field `button_key_inactive' 
has incomplete type
scripts/kconfig/lxdialog/dialog.h:113: error: field `button_label_active' 
has incomplete type
scripts/kconfig/lxdialog/dialog.h:114: error: field `button_label_inactive' 
has incomplete type
scripts/kconfig/lxdialog/dialog.h:115: error: field `inputbox' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:116: error: field `inputbox_border' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:117: error: field `searchbox' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:118: error: field `searchbox_title' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:119: error: field `searchbox_border' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:120: error: field `position_indicator' 
has incomplete type
scripts/kconfig/lxdialog/dialog.h:121: error: field `menubox' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:122: error: field `menubox_border' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:123: error: field `item' has incomplete type
scripts/kconfig/lxdialog/dialog.h:124: error: field `item_selected' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:125: error: field `tag' has incomplete type
scripts/kconfig/lxdialog/dialog.h:126: error: field `tag_selected' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:127: error: field `tag_key' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:128: error: field `tag_key_selected' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:129: error: field `check' has incomplete type
scripts/kconfig/lxdialog/dialog.h:130: error: field `check_selected' has 
incomplete type
scripts/kconfig/lxdialog/dialog.h:131: error: field `uarrow' has incomplete 
type
scripts/kconfig/lxdialog/dialog.h:132: error: field `darrow' has incomplete 
type
scripts/kconfig/lxdialog/dialog.h:186: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:186: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/dialog.h:192: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:192: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/dialog.h:194: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:194: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/dialog.h:195: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:195: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/dialog.h:196: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:196: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/dialog.h:197: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:198: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/dialog.h:199: error: syntax error before '*' token
scripts/kconfig/lxdialog/dialog.h:199: warning: function declaration isn't 
a prototype
scripts/kconfig/lxdialog/checklist.c:31: error: syntax error before '*' token
scripts/kconfig/lxdialog/checklist.c:32: warning: function declaration 
isn't a prototype
scripts/kconfig/lxdialog/checklist.c: In function `print_item':
scripts/kconfig/lxdialog/checklist.c:36: warning: implicit declaration of 
function `wattrset'
scripts/kconfig/lxdialog/checklist.c:36: error: `win' undeclared (first use 
in this function)
scripts/kconfig/lxdialog/checklist.c:36: error: (Each undeclared identifier 
is reported only once
scripts/kconfig/lxdialog/checklist.c:36: error: for each function it 
appears in.)
scripts/kconfig/lxdialog/checklist.c:37: warning: implicit declaration of 
function `wmove'
scripts/kconfig/lxdialog/checklist.c:37: error: `choice' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:39: warning: implicit declaration of 
function `waddch'
scripts/kconfig/lxdialog/checklist.c:42: error: `selected' undeclared 
(first use in this function)
scripts/kconfig/lxdialog/checklist.c:44: warning: implicit declaration of 
function `wprintw'
scripts/kconfig/lxdialog/checklist.c:47: warning: implicit declaration of 
function `mvwaddch'
scripts/kconfig/lxdialog/checklist.c:49: warning: implicit declaration of 
function `waddstr'
scripts/kconfig/lxdialog/checklist.c:52: warning: implicit declaration of 
function `wrefresh'
scripts/kconfig/lxdialog/checklist.c: At top level:
scripts/kconfig/lxdialog/checklist.c:59: error: syntax error before '*' token
scripts/kconfig/lxdialog/checklist.c:61: warning: function declaration 
isn't a prototype
scripts/kconfig/lxdialog/checklist.c: In function `print_arrows':
scripts/kconfig/lxdialog/checklist.c:62: error: `win' undeclared (first use 
in this function)
scripts/kconfig/lxdialog/checklist.c:62: error: `y' undeclared (first use 
in this function)
scripts/kconfig/lxdialog/checklist.c:62: error: `x' undeclared (first use 
in this function)
scripts/kconfig/lxdialog/checklist.c:64: error: `scroll' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:76: error: `height' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:79: error: `item_no' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:79: error: `choice' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c: At top level:
scripts/kconfig/lxdialog/checklist.c:95: error: syntax error before '*' token
scripts/kconfig/lxdialog/checklist.c:96: warning: function declaration 
isn't a prototype
scripts/kconfig/lxdialog/checklist.c: In function `print_buttons':
scripts/kconfig/lxdialog/checklist.c:97: error: `width' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:98: error: `height' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:100: error: `dialog' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:100: error: `selected' undeclared 
(first use in this function)
scripts/kconfig/lxdialog/checklist.c: In function `dialog_checklist':
scripts/kconfig/lxdialog/checklist.c:116: error: `WINDOW' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:116: error: `dialog' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:116: error: `list' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:116: warning: left-hand operand of 
comma expression has no effect
scripts/kconfig/lxdialog/checklist.c:129: warning: implicit declaration of 
function `getmaxy'
scripts/kconfig/lxdialog/checklist.c:129: error: `stdscr' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:130: error: `KEY_MAX' undeclared 
(first use in this function)
scripts/kconfig/lxdialog/checklist.c:131: warning: implicit declaration of 
function `getmaxx'
scripts/kconfig/lxdialog/checklist.c:137: error: `COLS' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:138: error: `LINES' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:142: warning: implicit declaration of 
function `newwin'
scripts/kconfig/lxdialog/checklist.c:143: warning: implicit declaration of 
function `keypad'
scripts/kconfig/lxdialog/checklist.c:143: error: `TRUE' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:164: warning: implicit declaration of 
function `subwin'
scripts/kconfig/lxdialog/checklist.c:197: warning: implicit declaration of 
function `wnoutrefresh'
scripts/kconfig/lxdialog/checklist.c:199: warning: implicit declaration of 
function `doupdate'
scripts/kconfig/lxdialog/checklist.c:202: warning: implicit declaration of 
function `wgetch'
scripts/kconfig/lxdialog/checklist.c:210: error: `KEY_UP' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:210: error: `KEY_DOWN' undeclared 
(first use in this function)
scripts/kconfig/lxdialog/checklist.c:220: error: `FALSE' undeclared (first 
use in this function)
scripts/kconfig/lxdialog/checklist.c:221: warning: implicit declaration of 
function `scrollok'
scripts/kconfig/lxdialog/checklist.c:222: warning: implicit declaration of 
function `wscrl'
scripts/kconfig/lxdialog/checklist.c:293: warning: implicit declaration of 
function `delwin'
scripts/kconfig/lxdialog/checklist.c:297: error: `KEY_LEFT' undeclared 
(first use in this function)
scripts/kconfig/lxdialog/checklist.c:298: error: `KEY_RIGHT' undeclared 
(first use in this function)
scripts/kconfig/lxdialog/checklist.c:312: error: `KEY_RESIZE' undeclared 
(first use in this function)
make[1]: *** [scripts/kconfig/lxdialog/checklist.o] Error 1
make: *** [menuconfig] Error 2


