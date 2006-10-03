Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030593AbWJCWFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbWJCWFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWJCWFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:05:52 -0400
Received: from av4.karneval.cz ([81.27.192.11]:59922 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030593AbWJCWFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:05:50 -0400
Message-id: <123430423123@karneval.cz>
Subject: [PATCH 4/6] Char: mxser_new, alter license terms
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed,  4 Oct 2006 00:05:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, alter license terms

- We don't need useless paragraphs in license terms.

- Add me to copyright.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 209164b6d9a593c402764e2735e9c3ff2d878835
tree 463a6e605d1fad587ce2eb0891a71d09b43f0a39
parent 356ef1dec5ac5b5c73636117691c5cc6bcd64a07
author Jiri Slaby <jirislaby@gmail.com> Tue, 03 Oct 2006 23:02:14 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 03 Oct 2006 23:02:14 +0200

 drivers/char/mxser_new.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 3c1a21f..465314b 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -2,31 +2,23 @@
  *          mxser.c  -- MOXA Smartio/Industio family multiport serial driver.
  *
  *      Copyright (C) 1999-2006  Moxa Technologies (support@moxa.com.tw).
+ *	Copyright (C) 2006       Jiri Slaby <jirislaby@gmail.com>
  *
- *      This code is loosely based on the Linux serial driver, written by
- *      Linus Torvalds, Theodore T'so and others.
+ *      This code is loosely based on the 1.8 moxa driver which is based on
+ *	Linux serial driver, written by Linus Torvalds, Theodore T'so and
+ *	others.
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
  *      the Free Software Foundation; either version 2 of the License, or
  *      (at your option) any later version.
  *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  *	Fed through a cleanup, indent and remove of non 2.6 code by Alan Cox
  *	<alan@redhat.com>. The original 1.8 code is available on www.moxa.com.
  *	- Fixed x86_64 cleanness
  *	- Fixed sleep with spinlock held in mxser_send_break
  */
 
-
 #include <linux/module.h>
 #include <linux/autoconf.h>
 #include <linux/errno.h>
