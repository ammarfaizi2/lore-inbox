Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbSKMHZX>; Wed, 13 Nov 2002 02:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbSKMHZX>; Wed, 13 Nov 2002 02:25:23 -0500
Received: from pc175.host14.starman.ee ([62.65.206.175]:260 "EHLO amd-laptop")
	by vger.kernel.org with ESMTP id <S267123AbSKMHZW>;
	Wed, 13 Nov 2002 02:25:22 -0500
Date: Wed, 13 Nov 2002 09:32:38 +0200
From: Priit Laes <amd@tt.ee>
To: linux-kernel@vger.kernel.org
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: GA-7VRXP is a bad motherboard [was Re: PDC20276 Linux driver]
Message-ID: <20021113073238.GA5066@amd-laptop.mshome.net>
References: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk> <1037133511.7047.12.camel@plokta.s8.com> <20021112211329.GB32036@amd-laptop.mshome.net> <200211122306.19195.ruth@ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211122306.19195.ruth@ivimey.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-gentoo-r9 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook (Ruth.Ivimey-Cook@ivimey.org) wrote:
> On Tuesday 12 November 2002 21:13, Priit Laes wrote:
> > Bryan O'Sullivan (bos@serpentine.com) wrote:
> > > On Tue, 2002-11-12 at 08:53, Geoffrey Lee wrote:
> > > The GA-7VRXP is a known bad motherboard.  It has a bad electrical
> > > interface to the AGP slot, so if you're using an AGP graphics card
> > > without falling back to PCI access, you are pretty much guaranteed
> > > system hangs or crashes after some time, depending on load.
> ....
> > The 1.1 version of this board would sometimes work and sometimes not
> > work. Odds are better of getting a functioning board, but if you have
> ....
> > I've(www.thetechboard.com) already tested the 2.0 version of the board with 
> 
> FWIW, I have the v1.1 GA-7VRXP using an Athlon XP 1800+ CPU and a GeForce3 
> Ti200, and all has so far been well. Don't know if I'm just lucky. No CPU 
> freq or voltage tweaks applied AFAICR.
> 
> The 20276 has been working fine controlling 2 of 4 disks of a software-RAID 
> (i.e.  md, not ataraid) volume. No problems so far, other than a driver clash 
> with an older Promise board: the BIOS for the MB wouldn't run with the old 
> card enabled. Fixed by swapping the old board out.
> 
Maybe you are the lucky one, who has rev 2.0 board... ;)
