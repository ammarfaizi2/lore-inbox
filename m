Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUGJTdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUGJTdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 15:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUGJTdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 15:33:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39664 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266357AbUGJTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 15:33:36 -0400
Date: Sat, 10 Jul 2004 21:33:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] NET_IPIP help: remove no longer available URL
Message-ID: <20040710193329.GW28324@fs.tum.de>
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

--- linux-2.6.7-mm7-full/net/ipv4/Kconfig.old	2004-07-10 21:27:06.000000000 +0200
+++ linux-2.6.7-mm7-full/net/ipv4/Kconfig	2004-07-10 21:27:28.000000000 +0200
@@ -196,8 +196,7 @@
 	  can be useful if you want to make your (or some other) machine
 	  appear on a different network than it physically is, or to use
 	  mobile-IP facilities (allowing laptops to seamlessly move between
-	  networks without changing their IP addresses; check out
-	  <http://anchor.cs.binghamton.edu/~mobileip/LJ/index.html>).
+	  networks without changing their IP addresses).
 
 	  Saying Y to this option will produce two modules ( = code which can
 	  be inserted in and removed from the running kernel whenever you

