Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTFXQJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTFXQIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:08:38 -0400
Received: from a235-76.dialup.iol.cz ([194.228.76.235]:41344 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S262490AbTFXQIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:08:22 -0400
Date: Tue, 24 Jun 2003 18:21:49 +0200 (CEST)
From: =?iso-8859-2?Q?Marcel_=A9ebek?= <sebek64@post.cz>
X-X-Sender: sebek@penguin
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/Changes
Message-ID: <Pine.LNX.4.56.0306231950060.8168@penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies file Documentation/Changes in kernel 2.5.73-bk1 -
fixes formatting and replaces old title 'Modutils' with new
'Module-Init-Tools'.


diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	Mon Jun 23 19:53:16 2003
+++ b/Documentation/Changes	Mon Jun 23 19:55:00 2003
@@ -1,4 +1,4 @@
-	Intro
+Intro
 =====

 This document is designed to provide a list of the minimum levels of
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


-- 
Marcel Sebek
e-mail: sebek64@post.cz
jabber: sebek@jabber.cz
linux user number: 307850

