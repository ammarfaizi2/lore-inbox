Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTKODXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 22:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTKODXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 22:23:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:14550 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261311AbTKODXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 22:23:22 -0500
Date: Fri, 14 Nov 2003 19:22:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Daniel Egger <degger@fhm.edu>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FB5973B.7040801@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0311141918420.9014-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Nov 2003, Nick Piggin wrote:
> 
> There are compressed incremental patches of the snapshots available:
> http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/incr/
> They average maybe 150KB per day.

I'd hope they average a _lot_ less lately. I've been trying to be an 
absolute _bastard_ when it comes to patches. 

Yeah, I just looked. Lately they've been averaging about 3-4kB per day.

And the sick thing is, I'm still not satisfied. I want it to become an 
absolute _trickle_ of one-liners that fix real bugs.

So if you want incrementals and have a 1200 baud modem - be happy. The 
last week or so has been a pretty good week.

		Linus

