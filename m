Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286127AbSAGTqT>; Mon, 7 Jan 2002 14:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286124AbSAGTp7>; Mon, 7 Jan 2002 14:45:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28083 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285972AbSAGTpz>;
	Mon, 7 Jan 2002 14:45:55 -0500
Date: Mon, 7 Jan 2002 14:45:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Jones <davej@suse.de>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201072017200.16327-100000@Appserv.suse.de>
Message-ID: <Pine.GSO.4.21.0201071443110.6842-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jan 2002, Dave Jones wrote:

> > It doesn't look like much work to do the stripping (I did a bunch of it
> > for the latest version of dietHotplug) but the porting, I have no idea
> > of what is needed there.
> > Anyone want to start up a klibc project? :)
> 
> That's not half a bad idea. If we want a _maintained_ libc for the kernel,
> having it maintained by kernel folks may make sense. There's nothing
> stopping us borrowing bits from dietlibc and friends after all.

Count me in.  Having libc that wouldn't make me puke at every look at
the source had been my dream since waaay back...

