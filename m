Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRA3Put>; Tue, 30 Jan 2001 10:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRA3Puk>; Tue, 30 Jan 2001 10:50:40 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:39178 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130388AbRA3Pub>; Tue, 30 Jan 2001 10:50:31 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFB6@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Multiplexing mouse input
Date: Tue, 30 Jan 2001 07:50:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "USB Guide" section on HID devices could also be
helpful to you.
http://www.linux-usb.org/USB-guide/x194.html

~Randy  /  503-677-5408
_______________________________________________

> From: Ben Ford [mailto:ben@kalifornia.com]
> 
> You are probably talking about an Xfree issue.  And yes it 
> can be done.  I
> know several people that do that.  Refer to the XFree86 website.
> 
> -b
> 
> 
> Dax Kelson wrote:
> 
> > My laptop has a touchpad builtin with two buttons, I also 
> have an external
> > PS2 and/or USB mouse (3 buttons with scroll wheel).
> >
> > I would like to be able to use the touchpad, and then plug 
> in the mouse
> > (with either PS2 or USB connector) and use it without reconfiguring
> > anything.
> >
> > In fact, it would be cool if I could use both at the same time.
> >
> > Is this possible with the new "Input Drivers" in the 2.4 
> kernel?  Is it
> > possible with Linux at all?
> >
> > As a comparison, at least two other OSes, Windows 2000 and 
> NetBSD 1.5
> > multiplex mouse input and allow use of two (or more!) mice 
> at the same
> > time.
> >
> > Dax Kelson
> >
> > NetBSD "wscons console driver" info:
> >
> > http://www.netbsd.org/Documentation/wscons/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
