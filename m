Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSKJLla>; Sun, 10 Nov 2002 06:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264819AbSKJLl3>; Sun, 10 Nov 2002 06:41:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264815AbSKJLl2>;
	Sun, 10 Nov 2002 06:41:28 -0500
Date: Thu, 7 Nov 2002 18:09:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix confusing comment
Message-ID: <20021107170936.GA432@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This little comment confused me a *lot*.
								Pavel


--- clean/arch/i386/kernel/head.S	2002-10-14 18:18:30.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/head.S	2002-11-02 22:36:58.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/i386/head.S -- the 32-bit startup code.
+ *  linux/arch/i386/kernel/head.S -- the 32-bit startup code.
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
