Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSEGWEB>; Tue, 7 May 2002 18:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEGWEA>; Tue, 7 May 2002 18:04:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:42947 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313505AbSEGWD7>; Tue, 7 May 2002 18:03:59 -0400
Date: Tue, 7 May 2002 16:03:50 -0600
Message-Id: <200205072203.g47M3o002102@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Patrick Mochel <mochel@osdl.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.33.0205071238000.6307-100000@segfault.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
> 
> On Tue, 7 May 2002, Thunder from the hill wrote:
> 
> > Hi,
> > 
> > > > >	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> > > /driverfs/class/ide/
> > > /driverfs/root/pci0/07.2/
> > > /driverfs/class/ide/0/
> > > /driverfs/class/ide/0/2
> > 
> > Why not fixing devfs for that? My root directory is messed up enough. We 
> > have dev, proc, tmp, ...
> 
> For one, I am of the camp that believes devfs is unfixable. 

But it's not actually broken, now that the locking is fixed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
