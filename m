Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRFNHNv>; Thu, 14 Jun 2001 03:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261213AbRFNHNl>; Thu, 14 Jun 2001 03:13:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:26854 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261198AbRFNHNW>;
	Thu, 14 Jun 2001 03:13:22 -0400
Date: Thu, 14 Jun 2001 10:12:41 +0300 (EEST)
From: "L. K." <lk@Aniela.EU.ORG>
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Message-ID: <Pine.LNX.4.21.0106141010150.1313-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.

a lot of people use linux on old machine in networking environmens as
routers/firewalls.


> 
> math-emu
> If support for i386 and i486 is going away, then so should math emulation.
> Every intel processor since the 486DX has an FPU unit built in. In fact
> shouldn't FPU support be a userspace responsibility anyway?
> 
> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc

ISA network cards are still used. Even the new motherboard producers add
an ISA slot on their MB.


> 
> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices for
> these buses.

Sometimes a ISA card performs better than a PCI one.




/me

