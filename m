Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKLPae>; Tue, 12 Nov 2002 10:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSKLPad>; Tue, 12 Nov 2002 10:30:33 -0500
Received: from [195.110.114.159] ([195.110.114.159]:11815 "EHLO trinityteam.it")
	by vger.kernel.org with ESMTP id <S261721AbSKLPad>;
	Tue, 12 Nov 2002 10:30:33 -0500
Date: Tue, 12 Nov 2002 16:43:18 +0100 (CET)
From: <ricci@esentar.trinityteam.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PDC20276 Linux driver
In-Reply-To: <1037116510.8746.49.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0211121637280.9631-100000@esentar.trinityteam.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 Nov 2002, Alan Cox wrote:

> > > > I have a Gigabyte 7DPXDW-P, a dual Athlon motherboard whit a FastTrak
> > > > controller onboard and I found some difficulties installing the driver.
> > > 
> > > Which driver are you using and which kernel ?
> > 
> > I tryed pdc202xx of 2.4.19 with and without ataraid and pdc202x_new (is it
> > correct?) of 2.5.46.
> 
> That is the correct driver yes. What problems are you seeing ?

During Slackware installation (whith kernel compiled by myself), after
about half a gigabyte written in the disk/disks all process
reading/writeing from/to the disks stop running, I cannot kill them, ps
show me them with the 'D' flag, I cannot umount the disk/disks.

