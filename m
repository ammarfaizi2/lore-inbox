Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbULKPvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbULKPvo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbULKPvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:51:44 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:1411 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261955AbULKPu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:50:57 -0500
Date: Sat, 11 Dec 2004 16:50:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: Fix header typo
Message-ID: <20041211155044.GA1937@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Fixes typo in header, please apply,
							Pavel

--- clean/kernel/power/main.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/main.c	2004-12-09 22:25:36.000000000 +0100
@@ -4,7 +4,7 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  * 
- * This file is release under the GPLv2
+ * This file is released under the GPLv2
  *
  */
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
