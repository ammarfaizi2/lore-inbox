Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbSKLW7f>; Tue, 12 Nov 2002 17:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKLW7f>; Tue, 12 Nov 2002 17:59:35 -0500
Received: from www.wotug.org ([194.106.52.201]:27475 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S267008AbSKLW7e>; Tue, 12 Nov 2002 17:59:34 -0500
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
To: Priit Laes <amd@tt.ee>, Linux-kernel@vger.kernel.org
Subject: Re: GA-7VRXP is a bad motherboard [was Re: PDC20276 Linux driver]
Date: Tue, 12 Nov 2002 23:06:19 +0000
User-Agent: KMail/1.5
Cc: "Bryan O'Sullivan" <bos@serpentine.com>
References: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk> <1037133511.7047.12.camel@plokta.s8.com> <20021112211329.GB32036@amd-laptop.mshome.net>
In-Reply-To: <20021112211329.GB32036@amd-laptop.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211122306.19195.ruth@ivimey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 November 2002 21:13, Priit Laes wrote:
> Bryan O'Sullivan (bos@serpentine.com) wrote:
> > On Tue, 2002-11-12 at 08:53, Geoffrey Lee wrote:
> > The GA-7VRXP is a known bad motherboard.  It has a bad electrical
> > interface to the AGP slot, so if you're using an AGP graphics card
> > without falling back to PCI access, you are pretty much guaranteed
> > system hangs or crashes after some time, depending on load.
....
> The 1.1 version of this board would sometimes work and sometimes not
> work. Odds are better of getting a functioning board, but if you have
....
> I've(www.thetechboard.com) already tested the 2.0 version of the board with 

FWIW, I have the v1.1 GA-7VRXP using an Athlon XP 1800+ CPU and a GeForce3 
Ti200, and all has so far been well. Don't know if I'm just lucky. No CPU 
freq or voltage tweaks applied AFAICR.

The 20276 has been working fine controlling 2 of 4 disks of a software-RAID 
(i.e.  md, not ataraid) volume. No problems so far, other than a driver clash 
with an older Promise board: the BIOS for the MB wouldn't run with the old 
card enabled. Fixed by swapping the old board out.

Ruth 

-- 
Ruth Ivimey-Cook
Software Engineer and Technical Author.
