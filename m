Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130563AbRADRui>; Thu, 4 Jan 2001 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRADRu2>; Thu, 4 Jan 2001 12:50:28 -0500
Received: from athe530-d029.otenet.gr ([212.205.239.29]:1540 "EHLO
	astarte.otenet.gr") by vger.kernel.org with ESMTP
	id <S130563AbRADRuQ>; Thu, 4 Jan 2001 12:50:16 -0500
Date: Thu, 4 Jan 2001 19:58:09 +0200 (EET)
From: Stefanos - Zacharias Zachariadis <s.zachariadis@cs.ucl.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: linux-2.4.0-prerelease & ntfs
Message-ID: <Pine.LNX.4.30.0101041953450.969-100000@lapvader.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running linux-2.2.18 and linux-2.4.0-prerelease on my laptop (p3-550,
440BX chipset). The machine dualboots with windows 2000, installed on
/dev/hda2 with NTFS. /dev/hda2 (as reported with fdisk) has 4707045
blocks. However, under linux-2.4.0-prerelease (and under
2.4.0-test13-pre3) df reports  37656356 1k blocks, which is clearly wrong
(the whole disk is 12GB long :). This doesn't happen under linux-2.2.18.
I'm sorry to spam everyone if this has already been reported. I'm be
willing to apply any patch and try everything etc. Please CC me if you
reply, because I'm not subscribed to the list.

Cheers,
Stefanos - Zacharias Zachariadis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
