Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSJSPqW>; Sat, 19 Oct 2002 11:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265613AbSJSPqW>; Sat, 19 Oct 2002 11:46:22 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:13271
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265612AbSJSPqV>; Sat, 19 Oct 2002 11:46:21 -0400
Date: Sat, 19 Oct 2002 11:52:18 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Greg KH <greg@kroah.com>
cc: pavel@bug.ucw.cz, <linux-kernel@vger.kernel.org>
Subject: Re: Zaurus support for usbnet.c
In-Reply-To: <20021019041047.GG12716@kroah.com>
Message-ID: <Pine.LNX.4.44.0210191149290.5873-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Greg KH wrote:

> On Fri, Oct 18, 2002 at 09:38:49PM -0400, Nicolas Pitre wrote:
> > On Fri, 18 Oct 2002, Greg KH wrote:
> > 
> > > Doesn't the usbdnet.c driver support the Zaurus?
> > 
> > Both the Zaurus and the iPAQ are using a SA1110 which is already supported 
> > by usbnet.
> 
> Yes, but that's on the client side of USB, right?  Pavel's patch is for
> the host side, which I think was supported by usbdnet for the Zaurus.

If both clients i.e. the iPAQ and the Zaurus are actually a SA1110, and if 
the iPAQ is already supported on both sides, then the Zaurus should work out 
of the box.


Nicolas

