Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUDEVHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDEVHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:07:41 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:33408 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263196AbUDEVFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:05:55 -0400
Date: Mon, 5 Apr 2004 23:05:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Right url for linux-on-laptops
Message-ID: <20040405210544.GA3541@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes url in Kconfig. Please apply,
						Pavel
--- tmp/linux/kernel/power/Kconfig	2004-01-09 20:24:27.000000000 +0100
+++ linux/kernel/power/Kconfig	2004-02-23 20:20:42.000000000 +0100
@@ -9,9 +9,9 @@
 
 	  Power Management is most important for battery powered laptop
 	  computers; if you have a laptop, check out the Linux Laptop home
-	  page on the WWW at
-	  <http://www.cs.utexas.edu/users/kharker/linux-laptop/> and the
-	  Battery Powered Linux mini-HOWTO, available from
+	  page on the WWW at <http://www.linux-on-laptops.com/> or
+	  Tuxmobil - Linux on Mobile Computers at <http://www.tuxmobil.org/>
+	  and the Battery Powered Linux mini-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
 	  Note that, even if you say N here, Linux on the x86 architecture

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
