Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293026AbSCOSIh>; Fri, 15 Mar 2002 13:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSCOSI2>; Fri, 15 Mar 2002 13:08:28 -0500
Received: from Expansa.sns.it ([192.167.206.189]:22533 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S293026AbSCOSIL>;
	Fri, 15 Mar 2002 13:08:11 -0500
Date: Fri, 15 Mar 2002 19:07:57 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thunder from the hill <thunder@ngforever.de>,
        <linux-kernel@vger.kernel.org>, Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
In-Reply-To: <E16lvju-0004Bj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203151903001.32102-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Mar 2002, Alan Cox wrote:

> > Hardware RAID is indeed better, but what you get using HPT370 IDE
> > controlelr is not hardware raid at all. Just read the code of the driver.
> > You get a software raid, period.
>
> Its not always that simple either.
>
> Software raid on aic7xxx totally blows away the Dell/AMI megaraid card I
> have, to the point the megaraid now resides in my testing bucket. The promise
> Supertrak 100 (now superceded by the SX6000) is also slower than the
> software IDE raid, but does use less CPU in RAID5 mode.
yes, I know, but I was talking "generaliter"
>
> Some hardware raid cards do seem to be winners. The Dell Perc2/QC aacraid
> based boards (233Mhz ARM etc) really shift. When I've had the chance to
> borrow the disks to test I've seen it running over 100Mbytes/second. It
> also supports nice stuff like online reconfiguration of active volumes.
> [$$stupid from Dell $$notalot from ebay ;)]
On my CISS Compaq array I get quite similar performances ;)


Luigi

