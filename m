Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUCWAbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 19:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUCWAbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 19:31:44 -0500
Received: from ozlabs.org ([203.10.76.45]:688 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261710AbUCWAbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 19:31:43 -0500
Subject: [TRIVIAL] patch for Documentation_Changes
From: Trivial Patch Monkey <trivial@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080001821.6594.139.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 11:30:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From:  Thomas Molina <tmolina@cablespeed.com>

---

--- trivial-2.6.5-rc2-bk2/Documentation/Changes.orig	2004-03-23 10:14:08.000000000 +1100
+++ trivial-2.6.5-rc2-bk2/Documentation/Changes	2004-03-23 10:14:08.000000000 +1100
@@ -112,8 +112,8 @@
 Architectural changes
 ---------------------
 
-DevFS is now in the kernel.  See Documentation/filesystems/devfs/* in
-the kernel source tree for all the gory details.
+DevFS has been obsoleted in favour of udev 
+(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
 
 32-bit UID support is now in place.  Have fun!
 
@@ -400,8 +400,3 @@
 o  <http://nfs.sourceforge.net/>
 

-Suggestions and corrections
-===========================
-
-Please feel free to submit changes, corrections, gripes, flames,
-money, etc. to me <chris.ricker@genetics.utah.edu>.  Happy Linuxing!
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Thomas Molina <tmolina@cablespeed.com>: patch for Documentation_Changes

