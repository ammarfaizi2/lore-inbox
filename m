Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbTI1ViM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbTI1ViM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:38:12 -0400
Received: from gprs147-229.eurotel.cz ([160.218.147.229]:63617 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262753AbTI1ViK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:38:10 -0400
Date: Sun, 28 Sep 2003 23:37:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [pm] Some typos
Message-ID: <20030928213736.GA16797@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes two small typos in powermanagment, please apply.

							Pavel

--- /usr/src/tmp/linux/kernel/power/disk.c	2003-09-28 22:06:44.000000000 +0200
+++ /usr/src/linux/kernel/power/disk.c	2003-09-28 22:50:47.000000000 +0200
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  *
- * This file is release under the GPLv2
+ * This file is released under the GPLv2.
  *
  */
 
--- /usr/src/tmp/linux/kernel/power/pmdisk.c	2003-09-28 22:06:44.000000000 +0200
+++ /usr/src/linux/kernel/power/pmdisk.c	2003-09-28 22:53:12.000000000 +0200
@@ -448,7 +448,7 @@
 
 
 /**
- *	copy_pages - Atmoically snapshot memory.
+ *	copy_pages - Atomically snapshot memory.
  *
  *	Iterate over all the pages in the system and copy each one 
  *	into its corresponding location in the pagedir.


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
