Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbTALNGs>; Sun, 12 Jan 2003 08:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbTALNGs>; Sun, 12 Jan 2003 08:06:48 -0500
Received: from ns.suse.de ([213.95.15.193]:29453 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265633AbTALNGr>;
	Sun, 12 Jan 2003 08:06:47 -0500
Date: Sun, 12 Jan 2003 14:15:35 +0100
From: Hubert Mantel <mantel@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
Message-ID: <20030112131535.GA8594@suse.de>
References: <200301111634.h0BGYGUt003680@eeyore.valparaiso.cl> <10213.1042313279@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10213.1042313279@passion.cambridge.redhat.com>
Organization: SuSE Linux AG, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.19-4GB
X-GPG-Key: 1024D/B0DFF780
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 11, David Woodhouse wrote:

> >  Great! The "complete source code" for the kernel does include each
> > and every single patch applied since linux-0.0.1? Guess I'll have to
> > complain to a certain Torvalds then...
> 
> > Don't be silly. "Complete source code" means the source needed to
> > rebuild the binary, nothing more. If that is a mangled version derived
> > from some other  source, so be it. You are explicitly allowed to
> > distribute changed versions, but only under GPL. [IANAL etc, so...]
> 
> I disagree. A preprocessed source file with all the variables renamed to 
> random strings would suffice to rebuild the binary, and is obviously not 
> acceptable -- being able to rebuild the binary is not the only criterion.
> 
> 	"The source code for a work means the preferred form of the work
> 	for making modifications to it."
> 
> Note that the GPL doesn't say you have to give it in the preferred form for 
> _building_ it, but the preferred form for _modifying_ it. 
> 
> In the opinion of many devlopers, the preferred form of the Linux kernel for
> maintaining it is a set of individual patches against the closest
> 'official' release, and not a tarball containing already-modified code. 

So you are saying that Alan Cox is violating the GPL since he releases his 
-ac kernels only as one single monolithic patch against the vanilla tree, 
not as individual patches (like Andrea Arcangeli does for example)?

I think the motivation for this ridiculous thread is very obvious.

> dwmw2
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
