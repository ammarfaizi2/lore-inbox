Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281918AbRKZQ4A>; Mon, 26 Nov 2001 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281919AbRKZQzv>; Mon, 26 Nov 2001 11:55:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:30448 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281918AbRKZQzk>; Mon, 26 Nov 2001 11:55:40 -0500
Date: Mon, 26 Nov 2001 17:55:34 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Serguei Miridonov <mirsev@cicese.mx>
cc: linux-kernel@vger.kernel.org
Subject: [patch] better URL for the bigphysarea patch
Message-ID: <Pine.NEB.4.42.0111261750290.2656-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serguei,

while searching for a version of the bigphysarea patch for another kernel
patch I noticed that you don't have read permissions at the root direct
http://www.polyware.nl/~middelin/patch/ of the URL that is mentionend in
Documentation/video4linux/Zoran. The patch below changes this to an URL
from where you can see all available patches.


--- Documentation/video4linux/Zoran.old	Mon Nov 26 17:46:18 2001
+++ Documentation/video4linux/Zoran	Mon Nov 26 17:47:26 2001
@@ -160,9 +160,9 @@
   set aside the necessary memory during boot time. There seem to be
   several versions of this patch against various kernel versions
   floating around in the net, you may obtain one e.g. from:
-  http://www.polyware.nl/~middelin/patch/bigphysarea-2.2.1.tar.gz You
-  also have to compile your driver AFTER installing that patch in order
-  to get it working
+  http://www.polyware.nl/~middelin/hob-v4l.html#bigphysarea
+  You also have to compile your driver AFTER installing that patch in
+  order to get it working

   or


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

