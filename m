Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSHJAyj>; Fri, 9 Aug 2002 20:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSHJAyj>; Fri, 9 Aug 2002 20:54:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16146 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316430AbSHJAyh>;
	Fri, 9 Aug 2002 20:54:37 -0400
Message-ID: <3D5464A4.84FC2DF3@zip.com.au>
Date: Fri, 09 Aug 2002 17:56:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/12] eyestrain relief
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The yellow-on-cyan hotkey, heading and positioning characters in
menuconfig are practically invisible.  Blue-on-cyan is tons better.



 colors.h |    6 +++---
 1 files changed, 3 insertions, 3 deletions

--- 2.5.30/scripts/lxdialog/colors.h~colours	Fri Aug  9 17:36:39 2002
+++ 2.5.30-akpm/scripts/lxdialog/colors.h	Fri Aug  9 17:36:39 2002
@@ -38,7 +38,7 @@
 #define DIALOG_BG                    COLOR_WHITE
 #define DIALOG_HL                    FALSE
 
-#define TITLE_FG                     COLOR_YELLOW
+#define TITLE_FG                     COLOR_BLUE
 #define TITLE_BG                     COLOR_WHITE
 #define TITLE_HL                     TRUE
 
@@ -110,7 +110,7 @@
 #define ITEM_SELECTED_BG             COLOR_BLUE
 #define ITEM_SELECTED_HL             TRUE
 
-#define TAG_FG                       COLOR_YELLOW
+#define TAG_FG                       COLOR_BLUE
 #define TAG_BG                       COLOR_WHITE
 #define TAG_HL                       TRUE
 
@@ -118,7 +118,7 @@
 #define TAG_SELECTED_BG              COLOR_BLUE
 #define TAG_SELECTED_HL              TRUE
 
-#define TAG_KEY_FG                   COLOR_YELLOW
+#define TAG_KEY_FG                   COLOR_BLUE
 #define TAG_KEY_BG                   COLOR_WHITE
 #define TAG_KEY_HL                   TRUE
 

.
