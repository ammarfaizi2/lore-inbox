Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVCHLkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVCHLkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVCHLhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:37:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:46059 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261975AbVCHLaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:30:21 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 12:25:25 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>,
       dvb list <linux-dvb@linuxtv.org>
Subject: [patch] v4l: MAINTAINERS file update.
Message-ID: <20050308112525.GA31360@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi folks,

Goodbye, and that thanks for all the fish ;)

After several years of v4l maintainance I'm going to switch
to a new work field and will not be able to spend much time
on maintaining video4linux and the drivers, so someone else
will have to step in.

I will not suddenly disappear from earth, I will be available
for questions and patch reviews for some time, but I'll stop
doing active development and most likely will not have the
time to act as central patch relay for all video4linux stuff.

cheers,

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 MAINTAINERS |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.11/MAINTAINERS
===================================================================
--- linux-2.6.11.orig/MAINTAINERS	2005-03-07 10:14:21.000000000 +0100
+++ linux-2.6.11/MAINTAINERS	2005-03-07 18:13:48.000000000 +0100
@@ -501,7 +501,7 @@ P:	Gerd Knorr
 M:	kraxel@bytesex.org
 L:	video4linux-list@redhat.com
 W:	http://bytesex.org/bttv/
-S:	Maintained
+S:	Orphan
 
 BUSLOGIC SCSI DRIVER
 P:	Leonard N. Zubkoff
@@ -2534,7 +2534,8 @@ S:	Maintained
 VIDEO FOR LINUX
 P:	Gerd Knorr
 M:	kraxel@bytesex.org
-S:	Maintained
+L:	video4linux-list@redhat.com
+S:	Orphan
 
 W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov

-- 
#define printk(args...) fprintf(stderr, ## args)
