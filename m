Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTAVWb1>; Wed, 22 Jan 2003 17:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbTAVWb0>; Wed, 22 Jan 2003 17:31:26 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:55814 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264688AbTAVWbY>; Wed, 22 Jan 2003 17:31:24 -0500
Date: Wed, 22 Jan 2003 22:40:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Markus Barenhoff <barenh_m@informatik.haw-hamburg.de>
cc: Sampson Fung <sampson106@i-cable.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem 2.5.59:SiS framebuffer failed to compile while Intel810
 is OK.
In-Reply-To: <20030121112730.GA864@aliosnet.de>
Message-ID: <Pine.LNX.4.44.0301222239420.4030-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I tested Intel810fb in kernel 2.5.59 with a success result.  MPlayer can
> > use fb to play vcd on my Intel Mainboard now.
> > 
> > Then, I want to test the DVD playback in my SiS mainboard that has a DVD
> > drive installed.  So I modify the .config to include SiS Framebuffer
> > support and failed to compile with errors below:
> > =================
> > 
> [sniped the build output]
> 
> The problem is, that the driver yet not been ported to the new
> framebuffer layer of 2.5. 
> 
> The maintainer of the driver writes on his site
> (http://www.webit.at/~twinny/linuxsis630.shtml): 
> "Kernel 2.5 support will have to wait a few weeks, it seems the fb
> API is still under development."

Tht is no longer the case. The core api is stable. There might be 
additions in the future but it is no longer constantly changing.

