Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbUKDX5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbUKDX5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUKDX4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:56:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:25268 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262518AbUKDX4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:56:08 -0500
Date: Fri, 5 Nov 2004 01:04:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Chris Ricker <kaboom@gatech.edu>
Cc: Chris Ricker <chris.ricker@genetics.utah.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [Patch] Tiny update to Documentation/Changes , link to latest version
 seems to be link to archive...
Message-ID: <Pine.LNX.4.61.0411050057340.3402@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a small patch that changes the text around the link to 
http://cyberbuzz.gatech.edu/kaboom/linux/Changes-2.4/ to say that it's an 
archive of the file in various formats instead of saying that the latest 
version can always be found there - the latest version found at that link 
is dated 14-Oct-2000 01:18 which can't be called recent by any stretch of 
the imagination :)

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc1-bk14-orig/Documentation/Changes linux-2.6.10-rc1-bk14/Documentation/Changes
--- linux-2.6.10-rc1-bk14-orig/Documentation/Changes	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6.10-rc1-bk14/Documentation/Changes	2004-11-05 00:55:47.000000000 +0100
@@ -15,9 +15,9 @@
 Axel Boldt, Alessandro Sigala, and countless other users all over the
 'net).
 
-The latest revision of this document, in various formats, can always
-be found at <http://cyberbuzz.gatech.edu/kaboom/linux/Changes-2.4/>.
-
+An archive of this document, in various formats, can be found at 
+<http://cyberbuzz.gatech.edu/kaboom/linux/Changes-2.4/> and the parent 
+directory.
 Feel free to translate this document.  If you do so, please send me a
 URL to your translation for inclusion in future revisions of this
 document.
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: October 29th, 2002
+Last updated: November 5th, 2004
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 


---
Jesper Juhl <juhl-lkml@dif.dk>


