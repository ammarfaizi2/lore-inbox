Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288200AbSACFxt>; Thu, 3 Jan 2002 00:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288210AbSACFxj>; Thu, 3 Jan 2002 00:53:39 -0500
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:47368 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288200AbSACFxW>;
	Thu, 3 Jan 2002 00:53:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: ISA slot detection on PCI systems?
Date: Thu, 3 Jan 2002 06:55:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@thyrsus.com>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102211038.C21788@thyrsus.com> <3C33EC64.8E505D54@zip.com.au> <3C33EF61.169E20AF@mandrakesoft.com>
In-Reply-To: <3C33EF61.169E20AF@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16M0qO-00012V-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 06:42 am, Jeff Garzik wrote:
> Andrew Morton wrote:
> > 
> > Dave Jones wrote:
> > >
> > > o  Aunt Tilley.
> > >    Vendors already ship an array of kernels which should make it
> > >    unnecessary for her to have to build a kernel.
> > >
> > 
> > There is a clear advantage to kernel developers in making things as
> > easy as possible for Aunt Tilley to use our latest output.
> > 
> > If the difficulty of installing the latest kernel prevents her from
> > doing that, she loses.  And so do we, because we don't get to know
> > if we've fixed her problem.
> > 
> > If Eric can get the entire download-config-build-install process
> > down to a single mouse click, he'll have done us all a great service.
> 
> OTOH if dumbing down the kernel config costs kernel developers
> productivity and increases the noise-to-signal ratio on lkml, it's a
> disservice...

Have you tried Eric's config code lately?  It's getting *really nice*.  The 
'search' feature alone makes it worth it, and the intelligent tree 
organization, and the consistency rules, and...

I'm now configging 2.4.17 with Eric-config, other trees with good-old-config, 
and I can tell you which one I prefer.

--
Daniel
