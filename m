Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWJCQgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWJCQgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWJCQgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:36:18 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:40456 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932149AbWJCQgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:36:17 -0400
Date: Tue, 3 Oct 2006 17:36:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove me from maintainers for serial and mmc
Message-ID: <20061003163611.GA10658@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As advertised earlier.  I invite interested parties to take over and
add their own entries as they see fit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 MAINTAINERS |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c752d1..6d67af0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -144,11 +144,9 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
-P:	Russell King
-M:	rmk+serial@arm.linux.org.uk
 L:	linux-serial@vger.kernel.org
 W:	http://serial.sourceforge.net
-S:	Maintained
+S:	Orphan
 
 8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
 P:	Paul Gortmaker
@@ -2003,9 +2001,7 @@ W:	http://www.atnf.csiro.au/~rgooch/linu
 S:	Maintained
 
 MULTIMEDIA CARD (MMC) SUBSYSTEM
-P:	Russell King
-M:	rmk+mmc@arm.linux.org.uk
-S:	Maintained
+S:	Orphan
 
 MULTISOUND SOUND DRIVER
 P:	Andrew Veliath

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
