Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289077AbSAJCDg>; Wed, 9 Jan 2002 21:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289110AbSAJCD0>; Wed, 9 Jan 2002 21:03:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:28668 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289077AbSAJCDT>;
	Wed, 9 Jan 2002 21:03:19 -0500
Date: Wed, 9 Jan 2002 17:46:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Bigggg Maxtor drives (fwd)
Message-ID: <Pine.LNX.4.10.10201091745470.5104-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another update request --


---------- Forwarded message ----------
Date: Mon, 31 Dec 2001 12:16:12 -0800
From: ablew@internetcds.com
To: andre@linux-ide.org
Subject: Bigggg Maxtor drives

Hi there.  As I understand it you're the linux IDE guy,
so if you don't mind answering a question for me, I'd
appriciate it.

I recently bought a Maxtor 4G160J8.  This hard drive is
Maxtor's biggest harddrive as of yet, coming in at
160GB.  Linux sees this drive as a mere 134 or so gigs
as shown by the below:

hde: Maxtor 4G160J8, ATA DISK drive
hde: 268435455 sectors (137439 MB) w/2048KiB Cache,
CHS=266305/16/63, UDMA(33) hde: hde1

Do I need to pass the kernel any arguments though grub
to see the full size, or is this just a kernel level
limitation?

Any help is appriciated.

Thanks,
-Aaron

