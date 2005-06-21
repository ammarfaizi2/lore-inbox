Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVFUUrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVFUUrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVFUUrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:47:07 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:4234 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262332AbVFUUqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:46:23 -0400
Message-ID: <42B876C1.6030704@brturbo.com.br>
Date: Tue, 21 Jun 2005 17:21:21 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>
Subject: V4L maintainer patch
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090101040709040102040202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101040709040102040202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch updates maintainer info for BTTV and V4L. Should be applied
on mainstream and -mm series.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

--------------090101040709040102040202
Content-Type: text/x-patch;
 name="v4l_maintainter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_maintainter.patch"

--- linux-2.6.12-mm1/MAINTAINERS.old	2005-06-21 17:03:48.000000000 -0300
+++ linux-2.6.12-mm1/MAINTAINERS	2005-06-21 17:04:50.000000000 -0300
@@ -505,11 +505,11 @@
 S:   Supported
 
 BTTV VIDEO4LINUX DRIVER
-P:	Gerd Knorr
-M:	kraxel@bytesex.org
+P:	Mauro Carvalho Chehab
+M:	mchehab@brturbo.com.br
 L:	video4linux-list@redhat.com
-W:	http://bytesex.org/bttv/
-S:	Orphan
+W:	http://linuxtv.org
+S:	Maintained
 
 BUSLOGIC SCSI DRIVER
 P:	Leonard N. Zubkoff
@@ -2661,10 +2661,11 @@
 S:      Maintained
 
 VIDEO FOR LINUX
-P:	Gerd Knorr
-M:	kraxel@bytesex.org
+P:	Mauro Carvalho Chehab
+M:	mchehab@brturbo.com.br
 L:	video4linux-list@redhat.com
-S:	Orphan
+W:	http://linuxtv.org
+S:	Maintained
 
 W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov

--------------090101040709040102040202--
