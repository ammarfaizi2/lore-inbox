Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262348AbRERPlN>; Fri, 18 May 2001 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262352AbRERPlD>; Fri, 18 May 2001 11:41:03 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:49108 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S262348AbRERPko>; Fri, 18 May 2001 11:40:44 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Charles Cazabon <linux-kernel@discworld.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 18 May 2001 07:30:07 -0700 (PDT)
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518093414.A21164@qcc.sk.ca>
Message-ID: <Pine.LNX.4.33.0105180727270.17872-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

why is it that so many people seem to think that it's a good thing to only
use precompiled kernels from the distro?

a kernel tuned for a particular machine can boot faster and run faster
then a 'stock' kernel.

unless you want to replace the kernel compile config options with a
similar sized menu to select between precompiled kernels with the correct
options (never mind what that will do to the size of the distros to ship
so many kernels)


David Lang

 On Fri, 18 May 2001, Charles Cazabon wrote:

> Date: Fri, 18 May 2001 09:34:14 -0600
> From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
> To: linux-kernel@vger.kernel.org
> Subject: Re: CML2 design philosophy heads-up
>
> Eric S. Raymond <esr@thyrsus.com> wrote:
> > Arjan van de Ven <arjanv@redhat.com>:
> > > Aunt Tillie doesn't even know what a kernel is, nor does she want
> > > to. I think it's fair to assume that people who configure and
> > > compile their own kernel (as opposed to using the distribution
> > > supplied ones) know what they are doing.
> >
> > I'd like to break these assumptions.  Or at the very least see how far
> > they can be bent.  I know this sounds crazy to a lot of hackers, but
> > I think there's a certain amount of unhelpful elitism and self-puffery
> > in the "kernels are hard to configure and they *should* be hard to
> > configure* attitude.  Let's give Aunt Tillie a chance to surprise us.
>
> Whether this is desirable or not is debatable.  The big question is:  why on
> earth would Aunt Tillie _want_ to compile a kernel at all, let alone
> re-configure one?  If she's using Linux, she's installing her distribution's
> pre-compiled kernel, and has no need for anything else.
>
> Simplifying the configuration interface so that "anyone" can use it seems like
> a waste of effort.  If there's an interested novice out there who wants to
> learn how to configure a kernel, they'll be sufficiently interested to invest
> an hour or two in learning how the whole process works.  Make it as simple as
> it needs to be, and no simpler.
>
> Charles
> --
> -----------------------------------------------------------------------
> Charles Cazabon                            <linux@discworld.dyndns.org>
> GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
> Any opinions expressed are just that -- my opinions.
> -----------------------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
