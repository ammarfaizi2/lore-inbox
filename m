Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTALNPA>; Sun, 12 Jan 2003 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTALNPA>; Sun, 12 Jan 2003 08:15:00 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:53145 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266081AbTALNOx>; Sun, 12 Jan 2003 08:14:53 -0500
Message-Id: <200301121323.h0CDNoSK003043@eeyore.valparaiso.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL? 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Sat, 11 Jan 2003 19:27:59 GMT." <10213.1042313279@passion.cambridge.redhat.com> 
Date: Sun, 12 Jan 2003 14:23:50 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:
> brand@jupiter.cs.uni-dortmund.de said:

[...]

> > Don't be silly. "Complete source code" means the source needed to
> > rebuild the binary, nothing more. If that is a mangled version derived
> > from some other  source, so be it. You are explicitly allowed to
> > distribute changed versions, but only under GPL. [IANAL etc, so...]

> I disagree. A preprocessed source file with all the variables renamed to 
> random strings would suffice to rebuild the binary, and is obviously not 
> acceptable -- being able to rebuild the binary is not the only criterion.

That isn't "source" in my book.

> 	"The source code for a work means the preferred form of the work
> 	for making modifications to it."

Right. And you can take the kernel-source RPM, and update drivers &c just
as you would on the original source + patchsets

> Note that the GPL doesn't say you have to give it in the preferred form for 
> _building_ it, but the preferred form for _modifying_ it. 

> In the opinion of many devlopers, the preferred form of the Linux kernel for
> maintaining it is a set of individual patches against the closest
> 'official' release, and not a tarball containing already-modified code.

That is exactly that: An opinion (or preference) of many (or so you do
think). Not legally binding, AFAIKS...
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
