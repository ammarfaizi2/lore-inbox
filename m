Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTKTXwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTKTXwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:52:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:8206 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263980AbTKTXwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:52:03 -0500
Date: Thu, 20 Nov 2003 18:01:46 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: jt@hpl.hp.com
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <20031120172454.GB14608@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.3.96.1031120174823.11021B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ replying to several posts ]

On Thu, 20 Nov 2003, Jean Tourrilhes wrote:

> 	That's why in the Howto the binary drivers are flagged
> accordingly. I even add explicit PPC driver for drivers I know work on
> PPC. What more do you need ?
> 	I still don't understand why people buy the wrong
> hardware. You have a choice, exercise it !

On Thu, 20 Nov 2003, Jean Tourrilhes wrote:

> > And what good would it be to have an entire driver subsystem populated
> > by binary-only drivers? That's not part of Linux, that's "welcome to
> > nvidia hell" for that subsystem too, and not just graphics cards.
> 
> 	What's the point in ruminating academic scenario. There exist
> fully open source drivers for quite a wide variety of modern wireless
> LAN cards. It's not like if you don't have the choice.

Unfortunately in the real world, many people *don't* have a choice. They
are limited to using what they can afford, or what their employer,
university, or thesis advisor provides or requires. People also have
system with built-in devices which either can't be removed or which will
void waranty if the devices are removed.

If the NDIS software allows development of OS drivers for the hardware
people *must* use, then they will at least have a choice of the operating
system. And if it improves reverse engineering some companies will avoid
NDIS just for that reason. Sounds like two good results to me.

The idea that all vendors would drop open spec and open source is totally
unrelated to reality, some companies provided that information when the
Linux market was tiny, they are not going to change, and neither are the
companies who don't release info now.

I'm curious if the NDIS stuff could be run in ring 1 or 2, being an old
MULTICS guy. Not for political reasons, just good tech.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


