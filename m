Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbTAAUHf>; Wed, 1 Jan 2003 15:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTAAUHf>; Wed, 1 Jan 2003 15:07:35 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:6655 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262913AbTAAUHe>; Wed, 1 Jan 2003 15:07:34 -0500
Date: Wed, 1 Jan 2003 15:15:10 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <20030101200717.GA17053@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0301011509420.27873-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

> > Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> > 
> >     First, there's no hint from that heading that hot-pluggable
> >   settings are hidden under there as well.
> 
> Well, PCMCIA pretty much suggests that, doesn't it?

you're right, based on the menus as they are now.  however,
as i think more about it, if you consider the next comment ...
> 
> >     In addition, why does "Bus options" not include the USB bus,
> >   the I2C bus, FireWire, etc?  A bus is a bus, isn't it?
> 
> Yes, this is a valid comment.  Placing USB under "Bus options"
> should be totally straightforward, but that one's for Greg KH
> to decide.

what might have been gnawing at me was, if USB (and other busses)
are added here as well, then *most* hotplug options would be in
one place.  just one way of looking at it.

> > Wireless networking/protocols
> > 
> >    Yes, I realize there's no such category, but there *should*
> >   be, which would include:
> > 
> > 	Wireless LAN (non ham-radio)
> > 	Bluetooth
> > 	IrDA
> 
> IrDA isn't necessarily networking, Bluetooth either.
> Wireless LAN is where it should be.

ok, i can buy that.  back to work here ... or, maybe not.
there must be a bowl game on TV somewhere.

rday

