Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbSLKP0b>; Wed, 11 Dec 2002 10:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267186AbSLKP0a>; Wed, 11 Dec 2002 10:26:30 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:42625 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S267187AbSLKP03>; Wed, 11 Dec 2002 10:26:29 -0500
Date: Wed, 11 Dec 2002 16:34:14 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021211153414.GQ8741@charite.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> <20021211090829.GD8741@charite.de> <1039622867.17709.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039622867.17709.31.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:
> On Wed, 2002-12-11 at 09:08, Ralf Hildebrandt wrote:
> > 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
> > 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
> > 00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
> > 00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
> > 00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
> 
> Drive and controllers are what ?

According to the 2.4.20 kernel (see
http://www.stahl.bau.tu-bs.de/~hildeb/kernel/2.4.20.jpg for a snapshot
of the boot process!) the drives are:  

hda: TOSHIBA MK4019GAX, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive

And the controller:
ICH3M: chipset revision 2

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
