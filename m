Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTA2IVX>; Wed, 29 Jan 2003 03:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTA2IVX>; Wed, 29 Jan 2003 03:21:23 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:44717 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S265369AbTA2IVX>; Wed, 29 Jan 2003 03:21:23 -0500
Message-Id: <200301290830.h0T8UKaE002508@eeyore.valparaiso.cl>
To: Catalin BOIE <util@ns2.deuroconsult.ro>
cc: Enlight <enlight@bentonrea.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem - See attached dmesg dump 
In-Reply-To: Your message of "Tue, 28 Jan 2003 14:21:11 +0200."
             <Pine.LNX.4.33.0301281419510.10512-100000@hosting.rdsbv.ro> 
Date: Wed, 29 Jan 2003 09:30:20 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE <util@ns2.deuroconsult.ro> said:
> > > While running make to build xfce3.8.18 I get an internal gcc error
> > > segmentation fault.  Also got similar error running rpmdrake.  Needless to
> > > say I can't finish the build.
> 
> I get this error too. gcc 3.2.1 seg faults a lot when compiling a kernel.
> Motherboard: gigabyte 7avx (I think) K400.
> Under Windows 2000 (don't ask why, please...) no BSOD.

Segfaults in gcc are usually caused by bad RAM (<http://www.memtest86.com>)
or broken fans (CPU mostly). "Win* works fine" is of no consecuence, Linux
works your machine to its limits, Win* doesn't come close; Linux does
complain when something goes wrong, Win* just sweeps the error under the
rug and hopes all goes well.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
