Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbSKMMGM>; Wed, 13 Nov 2002 07:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSKMMGM>; Wed, 13 Nov 2002 07:06:12 -0500
Received: from [195.110.114.159] ([195.110.114.159]:28199 "EHLO trinityteam.it")
	by vger.kernel.org with ESMTP id <S267190AbSKMMGL>;
	Wed, 13 Nov 2002 07:06:11 -0500
Date: Wed, 13 Nov 2002 13:19:11 +0100 (CET)
From: <ricci@esentar.trinityteam.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PDC20276 Linux driver
In-Reply-To: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0211131306010.10691-100000@esentar.trinityteam.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 Nov 2002, Alan Cox wrote:

> On Tue, 2002-11-12 at 15:43, ricci@trinityteam.it wrote:
> > During Slackware installation (whith kernel compiled by myself), after
> > about half a gigabyte written in the disk/disks all process
> > reading/writeing from/to the disks stop running, I cannot kill them, ps
> > show me them with the 'D' flag, I cannot umount the disk/disks.
> 
> What drives, exactly what messages are logged (dmesg) ?
> 

I made many tryes, and I taken for u 6 (I hope) significant tests
2.4.19 whith pdc drivers with and without softwer raid
2.5.46 whith pdc drivers with and without softwer raid
2.4.19 whith ataraid drivers with and without pdc drivers
all these tests issue the same problem.
For each try I have kernel config file and dmesg output and they are very
much text, so I think it isn't a good thig send all to u, tell me in
which u are interested and I'll send them.

If u think I can make a more usefull test, tell me about it.

Thank you again,
Daniele.

