Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTHWSYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTHWSYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 14:24:35 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:21377
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264052AbTHWSUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 14:20:52 -0400
Date: Sat, 23 Aug 2003 14:20:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       lkml@kcore.org
Subject: Re: Pentium-M?
In-Reply-To: <20030823180338.GA3562@ip68-4-255-84.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.53.0308231418070.15935@montezuma.fsmlabs.com>
References: <200308231236.h7NCaMl0018383@harpo.it.uu.se>
 <Pine.LNX.4.53.0308230901200.15935@montezuma.fsmlabs.com>
 <20030823180338.GA3562@ip68-4-255-84.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003, Barry K. Nathan wrote:

> On Sat, Aug 23, 2003 at 09:03:17AM -0400, Zwane Mwaikambo wrote:
> > That's interesting, intel compiler recommends P4 type optimisations, 
> > also worth noting that the P-M has hardware prefetch.
> 
> I'm pretty sure the "Tualatin" Pentium III's also have hardware prefetch.
> So it's not something specific to the P4 or P-M.

Someone else (in concordance with Mikael) also pointed out that the 
cacheline size is also the same as the PIII and not P4. So it's best 
going for PIII optimisations. It's best ignoring my previous comment then.

Thanks,
	Zwane

