Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTFIPtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTFIPtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:49:05 -0400
Received: from a172-183.dialup.iol.cz ([194.228.183.172]:4224 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S264476AbTFIPtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:49:02 -0400
Date: Mon, 9 Jun 2003 16:58:35 +0200 (CEST)
From: =?iso-8859-2?Q?Marcel_=A9ebek?= <sebek64@post.cz>
X-X-Sender: sebek@penguin
To: chris.ricker@genetics.utah.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/Changes
Message-ID: <Pine.LNX.4.56.0306091541160.515@penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this trivial patch fixes file Documentation/Changes in 2.5.70 kernel.


========================================================================
diff -urN linux-2.5.70/Documentation/Changes linux-2.5.70-new/Documentation/Changes
--- linux-2.5.70/Documentation/Changes	Mon Jun  9 16:01:32 2003
+++ linux-2.5.70-new/Documentation/Changes	Mon Jun  9 16:02:55 2003
@@ -141,7 +141,7 @@
 root of the Linux source for more information.

 Module-Init-Tools
---------
+-----------------

 A new module loader is now in the kernel that requires module-init-tools
 to use.  It is backward compatible with the 2.4.x series kernels.
@@ -300,8 +300,8 @@
 --------
 o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>

-Modutils
---------
+Module-Init-Tools
+-----------------
 o  <ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/>

 Mkinitrd
========================================================================

-- 
Marcel Sebek - sebek64 at post dot cz


