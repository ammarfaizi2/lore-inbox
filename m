Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318986AbSICV6g>; Tue, 3 Sep 2002 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318988AbSICV6g>; Tue, 3 Sep 2002 17:58:36 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:12418 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318986AbSICV6e>; Tue, 3 Sep 2002 17:58:34 -0400
Date: Tue, 3 Sep 2002 16:03:05 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Hacksaw <hacksaw@hacksaw.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
In-Reply-To: <1031090398.21439.42.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209031600140.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3 Sep 2002, Alan Cox wrote:
> If you have a good raid card then you can do online resizing, volume
> allocation, volume format changing, volume migration etc. For those
> cases you have to get the journalling right in order to be able to do
> that kind of thing properly

That's true, if you use partitions. I don't see the problem.

> Standard PC with 80Gb disks benefits from dynamic partitioning. But if
> you are pushed then you can shove 3ware 8500 PCI cards into your slots
> and get 12 SATA hotplug IDE channels per PCI slot.

Oh, well. IDE.

> Thats 12 * 200Gb hotswap per pci slot. Which given 4 slots of it would
> come out at a nice 9600Gb of disk. Maybe you can archive usenet on one
> PC after all 8)

Yes, but lately that's rather a funny than an enterprise solution.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

