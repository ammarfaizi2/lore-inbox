Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbRERPed>; Fri, 18 May 2001 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262345AbRERPeX>; Fri, 18 May 2001 11:34:23 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:271 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S262340AbRERPeQ>;
	Fri, 18 May 2001 11:34:16 -0400
Date: Fri, 18 May 2001 09:34:14 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010518093414.A21164@qcc.sk.ca>
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010518112625.A14309@thyrsus.com>; from esr@thyrsus.com on Fri, May 18, 2001 at 11:26:25AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> wrote:
> Arjan van de Ven <arjanv@redhat.com>:
> > Aunt Tillie doesn't even know what a kernel is, nor does she want
> > to. I think it's fair to assume that people who configure and
> > compile their own kernel (as opposed to using the distribution
> > supplied ones) know what they are doing.
> 
> I'd like to break these assumptions.  Or at the very least see how far
> they can be bent.  I know this sounds crazy to a lot of hackers, but 
> I think there's a certain amount of unhelpful elitism and self-puffery
> in the "kernels are hard to configure and they *should* be hard to 
> configure* attitude.  Let's give Aunt Tillie a chance to surprise us.

Whether this is desirable or not is debatable.  The big question is:  why on
earth would Aunt Tillie _want_ to compile a kernel at all, let alone
re-configure one?  If she's using Linux, she's installing her distribution's
pre-compiled kernel, and has no need for anything else.

Simplifying the configuration interface so that "anyone" can use it seems like
a waste of effort.  If there's an interested novice out there who wants to
learn how to configure a kernel, they'll be sufficiently interested to invest
an hour or two in learning how the whole process works.  Make it as simple as
it needs to be, and no simpler.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
Any opinions expressed are just that -- my opinions.
-----------------------------------------------------------------------
