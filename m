Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266359AbUGJTeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbUGJTeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266360AbUGJTeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:34:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37872 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266359AbUGJTeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:34:14 -0400
Date: Sat, 10 Jul 2004 21:34:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: netdev@oss.sgi.com, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] NET_IPIP help: remove no longer available URL
Message-ID: <20040710193407.GX28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves Bugzilla #2445 by removing a no longer available URL
from the help text for NET_IPIP.

Noted by Nils Hammar <m4341@bedug.com>.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.27-rc3-full/Documentation/Configure.help.old	2004-07-10 21:29:41.000000000 +0200
+++ linux-2.4.27-rc3-full/Documentation/Configure.help	2004-07-10 21:29:54.000000000 +0200
@@ -6172,8 +6172,7 @@
   can be useful if you want to make your (or some other) machine
   appear on a different network than it physically is, or to use
   mobile-IP facilities (allowing laptops to seamlessly move between
-  networks without changing their IP addresses; check out
-  <http://anchor.cs.binghamton.edu/~mobileip/LJ/index.html>).
+  networks without changing their IP addresses).
 
   Saying Y to this option will produce two modules ( = code which can
   be inserted in and removed from the running kernel whenever you
