Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbTABTO5>; Thu, 2 Jan 2003 14:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbTABTO5>; Thu, 2 Jan 2003 14:14:57 -0500
Received: from linux.kappa.ro ([194.102.255.131]:22424 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S266425AbTABTOz>;
	Thu, 2 Jan 2003 14:14:55 -0500
Date: Thu, 2 Jan 2003 21:23:16 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Samuel Flory <sflory@rackable.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
Message-ID: <20030102192316.GA28781@linux.kappa.ro>
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <20030102185921.GA28107@linux.kappa.ro> <3E14911C.7010009@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E14911C.7010009@rackable.com>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
> >IDE (rev 06)
> >
> >hdd: Maxtor 6Y060L0, ATA DISK drive
> >
> >the harddisk is DiamondPlus9 60GB 7200 rpm UDMA133 .. and the mainbboard 
> >is Soltek 75-FRV
> >with KT400 chipset
> > 
> >
> 
>  What's hdc?  Hdd is the secondary slave.  If it's the only device on 
> the chain you should make sure you jumper the drive as a master.

HDC it's a CD-RW .. it was not used at the time of the error ( i was doing
mke2fs on hdd1 when I got those errors in dmesg ).

> 
> 
> -- 
> There is no such thing as obsolete hardware.
> Merely hardware that other people don't want.
> (The Second Rule of Hardware Acquisition)
> Sam Flory  <sflory@rackable.com>
> 
> 

-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
