Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTA2IsD>; Wed, 29 Jan 2003 03:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTA2IsD>; Wed, 29 Jan 2003 03:48:03 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:1938 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id <S265409AbTA2IsC>;
	Wed, 29 Jan 2003 03:48:02 -0500
Date: Wed, 29 Jan 2003 10:57:09 +0200 (EET)
From: Catalin BOIE <util@ns2.deuroconsult.ro>
X-X-Sender: <util@hosting.rdsbv.ro>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Catalin BOIE <util@ns2.deuroconsult.ro>, Enlight <enlight@bentonrea.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem - See attached dmesg dump 
In-Reply-To: <200301290830.h0T8UKaE002508@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.33.0301291055450.23988-100000@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Horst von Brand wrote:

> Catalin BOIE <util@ns2.deuroconsult.ro> said:
> > > > While running make to build xfce3.8.18 I get an internal gcc error
> > > > segmentation fault.  Also got similar error running rpmdrake.  Needless to
> > > > say I can't finish the build.
> >
> > I get this error too. gcc 3.2.1 seg faults a lot when compiling a kernel.
> > Motherboard: gigabyte 7avx (I think) K400.
> > Under Windows 2000 (don't ask why, please...) no BSOD.
>
> Segfaults in gcc are usually caused by bad RAM (<http://www.memtest86.com>)
> or broken fans (CPU mostly). "Win* works fine" is of no consecuence, Linux
> works your machine to its limits, Win* doesn't come close; Linux does
> complain when something goes wrong, Win* just sweeps the error under the
> rug and hopes all goes well.

I checked the memory and it's ok.
The computer is new.
The only thing that looks strange is the CPU temperature (68 Celsius).
CPU is Athlon XP 1700+
It has a big fan that spins at ~5000 rpm.

Thanks!

> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro

