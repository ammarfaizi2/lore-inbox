Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTAKQ3L>; Sat, 11 Jan 2003 11:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTAKQ3L>; Sat, 11 Jan 2003 11:29:11 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:39857 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267273AbTAKQ3K>; Sat, 11 Jan 2003 11:29:10 -0500
Message-Id: <200301111634.h0BGYGUt003680@eeyore.valparaiso.cl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL? 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Fri, 10 Jan 2003 13:19:17 +0100." <20030110121917.GJ6626@fs.tum.de> 
Date: Sat, 11 Jan 2003 17:34:16 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> said:
> On Fri, Jan 10, 2003 at 11:55:21AM +0100, Horst von Brand wrote:
> 
> >...
> > they aren't in violation. Sure, having a look at the non-official patches
> > they apply would be nice, but not mandated by GPL.
> 
> [ disclaimer: the UnitedLinux issue in the subject is already resolved ]

Right.

> This is wrong. Section 3 of the GPL says that you have to accompany the
> binaries either with the complete source code (and this includes all
> patches you have applied) or with a "written offer, valid for at least
> three years, to give any third party for a charge no more than your cost
> of physically performing source distribution, a complete
> machine-readable copy of the corresponding source code".

Great! The "complete source code" for the kernel does include each and
every single patch applied since linux-0.0.1? Guess I'll have to complain
to a certain Torvalds then...

Don't be silly. "Complete source code" means the source needed to rebuild
the binary, nothing more. If that is a mangled version derived from some
other  source, so be it. You are explicitly allowed to distribute changed
versions, but only under GPL. [IANAL etc, so...]
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
