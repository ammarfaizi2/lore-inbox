Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280037AbRJ3REz>; Tue, 30 Oct 2001 12:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280053AbRJ3REq>; Tue, 30 Oct 2001 12:04:46 -0500
Received: from www-cache.iisc.ernet.in ([144.16.64.3]:60427 "EHLO
	iisc.ernet.in") by vger.kernel.org with ESMTP id <S280035AbRJ3RE1>;
	Tue, 30 Oct 2001 12:04:27 -0500
Date: Tue, 30 Oct 2001 22:35:00 +0530 (GMT+05:30)
From: "V.Muni Chandra Reddy" <mcreddy@ece.iisc.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic :  Unable to mount root fs on 03:06
Message-ID: <Pine.SUN.3.96.1011030223256.24724A-100000@eis>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently upgraded my Thinkpad with 20GB HDD, and installed Redhat 7.1
with kernel version 2.4.2-2. After this, I am facing a strange problem
booting
under Linux. BTW, my machine also has Windows :) 

Whenever I am in Linux, and _softboot_ the system by choosing Linux at the
lilo prompt, the boot process stops with the following message.

---------------------------------------------------------------------------
EXT2-fs: unable to read superblock
isofs_read_super: bread failed, dev=03:06, iso_blknum=16,block=32
Kernel panic: Unable to mount root fs on 03:06
---------------------------------------------------------------------------

Surprisingly, whenever I _hardboot_ the system and choose Linux at the
lilo
the system boots normally without any problem.

Can you help me out with this problem ?


Regards,
M.C.Reddy.

