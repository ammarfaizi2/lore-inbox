Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbSLEUcG>; Thu, 5 Dec 2002 15:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbSLEUcG>; Thu, 5 Dec 2002 15:32:06 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:32260 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267384AbSLEUcF>; Thu, 5 Dec 2002 15:32:05 -0500
Date: Thu, 5 Dec 2002 20:39:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Framebuffer oddness in 2.5.50
In-Reply-To: <20021205164353.GA9658@suse.de>
Message-ID: <Pine.LNX.4.44.0212052038040.31967-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Something really odd just happened. I was on console,
> and hit alt-f7, which flipped me back to X.
> There were small blinking parts of the screen, which
> I think was actually the fb cursor, but it was sort of skewed
> across the screen. I could click in windows, but when
> I typed, nothing would appear. I pressed alt-ctrl-f1,
> and got back to the console, where everything I had just
> typed (whilst I thought I was in X) was.
> 
> Totally wierd, and try as I might, I can't reproduce it at will.
> 
> Nvidia graphic card (no binary crap loaded), vesafb.

That is totally weird. Is with my latest patches for the standard 2.5.50 tree
or just a vanilla tree?



