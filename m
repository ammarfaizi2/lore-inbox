Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTDLHrX (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 03:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTDLHrX (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 03:47:23 -0400
Received: from pdbn-d9bb86ba.pool.mediaWays.net ([217.187.134.186]:57102 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S263185AbTDLHrW (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 03:47:22 -0400
Date: Sat, 12 Apr 2003 09:58:59 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: USB Keyboard in 2.5 bitkeeper...
Message-ID: <20030412075859.GA19294@citd.de>
References: <200304111941.16563.ivg2@cornell.edu> <1050112147.3778.5.camel@sharra.ivimey.org> <200304112339.19484.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304112339.19484.ivg2@cornell.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:39:19PM -0400, Ivan Gyurdiev wrote:
> On Friday 11 April 2003 21:49, Ruth Ivimey-Cook wrote:
> > On Sat, 2003-04-12 at 00:41, Ivan Gyurdiev wrote:
> > > input1: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb1:3.0
> > > input2: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb1:3.1
> > >
> > > That's only a keyboard, but interestingly it shows up as a keyboard AND
> > > mouse. (This kernel is 2.4.21-pre5-ac3)
> >
> > I have a USB keyboard (a BTC model 9000) that has a PS/2 mouse port on
> > the back. When USB enumerates it I get a keyboard controller and a mouse
> > controller connection... I guess that's the sort of thing you have.
> >
> > Ruth
> 
> my keyboard has no mouse port on the back.

Exists a version of the keyboard with a mouse-port, or a version with a
"mouse"-thing. (Track-Point, Track-Ball, Glide-Point, or whatever you
call it today.)

Then there is a chance that they only use a single version of the
chipset, which includes a mouse-port.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

