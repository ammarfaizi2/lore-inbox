Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTHWNGa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTHWNG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:06:29 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:16256
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262665AbTHWNG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:06:27 -0400
Date: Sat, 23 Aug 2003 09:03:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org, lkml@kcore.org
Subject: Re: Pentium-M?
In-Reply-To: <200308231236.h7NCaMl0018383@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.53.0308230901200.15935@montezuma.fsmlabs.com>
References: <200308231236.h7NCaMl0018383@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003, Mikael Pettersson wrote:

> On Sat, 23 Aug 2003 13:50:02 +0200, Jan De Luyck <lkml@kcore.org> wrote:
> >Just a short question. For the Pentium-M as used in the centrino platform, 
> >what do I select in the 2.6.0-test4 kernel configuration as the CPU?
> >
> >I figure it's not a PIV, but is it a P3? Or is it something special?
> 
> The P-M core is PIII, to which SSE2, some P4-like model-specific
> registers, and (it seems) a P4 bus were added.
> 
> For now, treat it simply as a PIII.

That's interesting, intel compiler recommends P4 type optimisations, 
also worth noting that the P-M has hardware prefetch.
