Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281921AbRLKRHT>; Tue, 11 Dec 2001 12:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRLKRHJ>; Tue, 11 Dec 2001 12:07:09 -0500
Received: from ps.ksky.ne.jp ([210.233.160.3]:56195 "EHLO ps.ksky.ne.jp")
	by vger.kernel.org with ESMTP id <S282064AbRLKRG6>;
	Tue, 11 Dec 2001 12:06:58 -0500
To: Alan.Cox@linux.org, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, hng@ps.ksky.ne.jp
Subject: SubmittingDrivers of Linux kernel Documentation
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011212020318D.hng@ps.ksky.ne.jp>
Date: Wed, 12 Dec 2001 02:03:18 +0900
From: Hirokazu Nomoto <hng@ps.ksky.ne.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I think there is some typo about SubmittingDrivers of Linux kernel
Documentation.
So, I made a patch for 2.2.20 and 2.4.16.
Please apply them.
I don't know this maintainer or autor, so I send you.

regards,
Hiro

For 2.2.20:
======================================================================
--- SubmittingDrivers	Sat Nov  3 01:39:05 2001
+++ SubmittingDrivers.new	Wed Dec 12 01:50:00 2001
@@ -14,7 +14,7 @@
 site is http://www.lanana.org/. This also deals with allocating numbers for
 devices that are not going to be submitted to the mainstream kernel.
 
-If you don't use assigned numbers then when you device is submitted it will
+If you don't use assigned numbers then when your device is submitted it will
 get given an assigned number even if that is different from values you may
 have shipped to customers before.
 
@@ -57,7 +57,7 @@
 		in Documentation/CodingStyle. If you have sections of code
 		that need to be in other formats, for example because they
 		are shared with a windows driver kit and you want to
-		maintain them just once seperate them out nicely and note
+		maintain them just once separate them out nicely and note
 		this fact.
 
 Portability:	Pointers are not always 32bits, people do not all have
======================================================================
For 2.4.16:
======================================================================
--- SubmittingDrivers	Tue Aug 28 00:59:16 2001
+++ SubmittingDrivers.new	Wed Dec 12 01:52:47 2001
@@ -18,7 +18,7 @@
 also deals with allocating numbers for devices that are not going to
 be submitted to the mainstream kernel.
 
-If you don't use assigned numbers then when you device is submitted it will
+If you don't use assigned numbers then when your device is submitted it will
 get given an assigned number even if that is different from values you may
 have shipped to customers before.
 
@@ -61,7 +61,7 @@
 		in Documentation/CodingStyle. If you have sections of code
 		that need to be in other formats, for example because they
 		are shared with a windows driver kit and you want to
-		maintain them just once seperate them out nicely and note
+		maintain them just once separate them out nicely and note
 		this fact.
 
 Portability:	Pointers are not always 32bits, people do not all have
======================================================================
