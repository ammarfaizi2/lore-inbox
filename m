Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290470AbSA3TiQ>; Wed, 30 Jan 2002 14:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290472AbSA3TiG>; Wed, 30 Jan 2002 14:38:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51672 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290470AbSA3Th4>;
	Wed, 30 Jan 2002 14:37:56 -0500
Date: Wed, 30 Jan 2002 14:37:55 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, vda@port.imtp.ilyichevsk.odessa.ua,
        David Weinehall <tao@acc.umu.se>,
        Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
Message-ID: <20020130143755.A1391@havoc.gtf.org>
In-Reply-To: <200201301232.g0UCWmt10496@Port.imtp.ilyichevsk.odessa.ua> <E16VwTl-0007VJ-00@the-village.bc.nu> <200201301804.g0UI4nQ13064@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201301804.g0UI4nQ13064@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Jan 30, 2002 at 11:04:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 11:04:49AM -0700, Richard Gooch wrote:
> I'd prefer if tree maintainers (that means you, Alan:-) don't apply
> devfs patches that didn't come from me. I've already posted a patch
> which cleans up *all* the remaining printk()'s. In fact, it's a pair
> of patches, one for 2.4.x and one for 2.5.x. That was yesterday. Today
> I'm still seeing this thread being beaten to death.

First, before I get to my point, I want to say that I fully understand
your argument, and I also bitch when people patch the files I maintain.

But.

That is courtesy, not a right or need.  The -beauty- of open source is
that anyone can hack on my files, or devfs, and if the patch makes
sense, it will get applied, regardless of whether I am a crotchety old
a-hole or not.  (I am :))

	Jeff



