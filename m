Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbRFAPMQ>; Fri, 1 Jun 2001 11:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbRFAPMG>; Fri, 1 Jun 2001 11:12:06 -0400
Received: from mustart.heime.net ([194.234.65.222]:18692 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S262982AbRFAPL4>; Fri, 1 Jun 2001 11:11:56 -0400
Date: Fri, 1 Jun 2001 17:11:54 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: union mounting file systems... retry #1
Message-ID: <Pine.LNX.4.30.0106011706320.2959-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

After reading "Wonderful World of Linux 2.4" (Penguin Wizard) at
http://www.linuxdevices.com/files/misc/WWOL2.4.html, I found
somthing about union mounting file systems under "Linux internals",
(seventh paragraph).

I've been trying to find out how to do this, but I just fail. Some places
I get the expression that I just have to mount the first file system, and
afterwards, just use the option "-o union" to mount, but still, the
originally mounted file system will disappear as soon as I mount another
on top of it.

Q: Is it possible to union mount file systems in linux 2.4 (currently
   using 2.4.5)?

Q: Should I just go home and start doing my homework?

Best regards

roy

