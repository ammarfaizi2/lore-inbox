Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270521AbRHSOvv>; Sun, 19 Aug 2001 10:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270539AbRHSOvl>; Sun, 19 Aug 2001 10:51:41 -0400
Received: from [194.102.102.3] ([194.102.102.3]:516 "EHLO ns1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S270521AbRHSOv1>;
	Sun, 19 Aug 2001 10:51:27 -0400
Date: Sun, 19 Aug 2001 17:51:27 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: <linux-kernel@vger.kernel.org>
Subject: reiserfs question
Message-ID: <Pine.LNX.4.33.0108191745310.365-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I run slackware-linux 8.0 and when I restart my box without issuing the
halt command, I see the following message when the kernel boots:

reiserfs: checking transaction log (device 03:01) ...
Warning, log replay starting on readonly filesystem
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 184k freed
Adding Swap: 100796k swap-space (priority -1)

My question is: why does it says "Warning...." ? The boot scripts are the
ones installed by slackware installer by default. Is the root filesystem
supposed to be mounted read/write at boot (i ask this because when I had
an ext2 partition it was mounted first readonly, and then readwrite) ?


Regards,



