Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTAKJsH>; Sat, 11 Jan 2003 04:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267014AbTAKJsH>; Sat, 11 Jan 2003 04:48:07 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:56334
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266999AbTAKJsG>; Sat, 11 Jan 2003 04:48:06 -0500
Date: Sat, 11 Jan 2003 04:56:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Adrian Bunk <bunk@fs.tum.de>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.56
In-Reply-To: <20030111094345.GI10486@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0301110454380.4270-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Adrian Bunk wrote:

> On Fri, Jan 10, 2003 at 12:26:56PM -0800, Linus Torvalds wrote:
> 
> >...
> > Summary of changes from v2.5.55 to v2.5.56
> > ============================================
> >...
> > Dave Jones <davej@codemonkey.org.uk>:
> >...
> >   o [WATCHDOG] Add several new watchdog drivers from 2.4
> >...
> 
> FYI:
> 
> drivers/char/watchdog/sc1200wdt.c doesn't compile:

I can take care of that, although i think this driver could be removed due 
scx200_wdt.c supporting the same hardware. I'll look into it.

	Zwane
-- 
function.linuxpower.ca

