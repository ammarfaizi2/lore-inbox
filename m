Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265018AbUETHKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265018AbUETHKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUETHKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:10:22 -0400
Received: from ozlabs.org ([203.10.76.45]:5517 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265024AbUETHIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:08:40 -0400
Subject: [TRIVIAL] doc update for bk usage
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1085036543.24931.154.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 17:08:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From:  carbonated beverage <ramune@net-ronin.org>

---
  bk://... appears to be dead, use http://... instead.
  
  ===== Documentation/BK-usage/bk-kernel-howto.txt 1.7 vs edited =====

--- trivial-2.6.6-bk6/Documentation/BK-usage/bk-kernel-howto.txt.orig	2004-05-20 15:59:35.000000000 +1000
+++ trivial-2.6.6-bk6/Documentation/BK-usage/bk-kernel-howto.txt	2004-05-20 15:59:35.000000000 +1000
@@ -279,5 +279,5 @@
    for my long-lived kernel branch?
 A. Yes.  This requires BK 3.x, though.
 
-	bk export -tpatch -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
+	bk export -tpatch -r`bk repogca http://linux.bkbits.net/linux-2.5`,+
 
--- trivial-2.6.6-bk6/Documentation/BK-usage/gcapatch.orig	2004-05-20 15:59:35.000000000 +1000
+++ trivial-2.6.6-bk6/Documentation/BK-usage/gcapatch	2004-05-20 15:59:35.000000000 +1000
@@ -5,4 +5,4 @@
 # Usage: gcapatch > foo.patch
 #
 
-bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
+bk export -tpatch -hdu -r`bk repogca http://linux.bkbits.net/linux-2.5`,+
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: carbonated beverage <ramune@net-ronin.org>: doc update for bk usage

