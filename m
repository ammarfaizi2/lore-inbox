Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274896AbRJAPXK>; Mon, 1 Oct 2001 11:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275139AbRJAPXA>; Mon, 1 Oct 2001 11:23:00 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:19219 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S274896AbRJAPWu>; Mon, 1 Oct 2001 11:22:50 -0400
Date: Mon, 1 Oct 2001 10:23:08 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
In-Reply-To: <Pine.LNX.4.10.10110011107350.13303-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.31.0110011022410.4216-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

On Mon, 1 Oct 2001, Mark Hahn wrote:

> > We began with a system with a Seagate system drive (master, ide0), same
> > model as in Marvin's post..   IDE cd rom
> > as slave on the ide0 bus, and two IBM data drives on the ide1 bus.
> ...
> > whenever it does happen.  It is wrong to think this problem happens
> > only with Seagate drives.
>
> indeed, it seems that the most common trigger for this problem
> is simply putting two devices from different vendors on the same channel.
> Seagate drives are fairly notorious for not getting along with others.
>
> it's best to think of IDE as a point-to-point link.

True... however, we were still able to reproduce these problems
with only one drive on the bus.

Steve



>
> regards, mark hahn.
>
>

