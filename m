Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUHQKlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUHQKlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 06:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUHQKlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 06:41:19 -0400
Received: from gprs214-155.eurotel.cz ([160.218.214.155]:15496 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265031AbUHQKlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 06:41:12 -0400
Date: Tue, 17 Aug 2004 12:40:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: typo in laptop_mode.txt
Message-ID: <20040817104058.GA19921@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch is thanks to pavouk, please apply.
								Pavel

--- tmp/linux/Documentation/laptop-mode.txt	2004-08-15 19:14:52.000000000 +0200
+++ linux/Documentation/laptop-mode.txt	2004-08-15 19:20:08.000000000 +0200
@@ -249,7 +249,7 @@
 # playing.
 #READAHEAD=4096
 
-# Shall we remount journaled fs. with appropiate commit interval? (1=yes)
+# Shall we remount journaled fs. with appropriate commit interval? (1=yes)
 #DO_REMOUNTS=1
 
 # And shall we add the "noatime" option to that as well? (1=yes)

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
