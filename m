Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSGDJ7M>; Thu, 4 Jul 2002 05:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSGDJ7L>; Thu, 4 Jul 2002 05:59:11 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:1694 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317385AbSGDJ7K>; Thu, 4 Jul 2002 05:59:10 -0400
Date: Thu, 4 Jul 2002 11:29:53 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cmd649 not working with 2 CPU box
In-Reply-To: <3D240EB9.33B93BFA@vtc.edu.hk>
Message-ID: <Pine.LNX.4.44.0207041128570.21993-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Nick Urbanik wrote:

> hda: ATAPI CD-ROM DRIVE 50X MAXIMUM, ATAPI CD/DVD-ROM drive
> hdc: ST360021A, ATA DISK drive
> hde: ST320420A, ATA DISK drive
> hde: IRQ probe failed (0xfffffef8)
> hdf: IRQ probe failed (0xfffffef8)
> hdf: IRQ probe failed (0xfffffef8)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2: DISABLED, NO IRQ
> ^^^^^^^^^^^^^^^^^^^^^^____________Oh dear!!!!

Does booting with noapic change anything?

Cheers,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

