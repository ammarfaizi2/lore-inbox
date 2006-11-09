Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966044AbWKIVLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966044AbWKIVLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966058AbWKIVLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:11:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13327 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966044AbWKIVLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:11:18 -0500
Date: Thu, 9 Nov 2006 22:11:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061109211121.GW4729@stusta.de>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com> <1163024531.3138.406.camel@laptopd505.fenrus.org> <20061108145150.80ceebf4.akpm@osdl.org> <1163064401.3138.472.camel@laptopd505.fenrus.org> <20061109013645.7bef848d.akpm@osdl.org> <1163065920.3138.486.camel@laptopd505.fenrus.org> <20061109111212.eee33367.akpm@osdl.org> <1163100115.3138.524.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163100115.3138.524.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 08:21:55PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-09 at 11:12 -0800, Andrew Morton wrote:
> > On Thu, 09 Nov 2006 10:52:00 +0100
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > > Do you have the
> > > impression that high quality bug reports on lkml (with this I mean ones
> > > where there is sufficient information, which are not a request for
> > > support and where the reporter actually answers questions that are asked
> > > him) are not getting reasonable attention? 
> > 
> > Yes.
> > 
> > And why does the report quality matter?  
> 
> because it matters where people spend their time. And if you count
> bugreports that are actually distro support questions and then say "but
> these aren't looked at" it's not fair either.
> 
> > If there's insufficient info you
> > just ask for more.
> 
> and that does happen. And half the time people just remain silent :(
> I know I look at a whole bunch of bugreports in areas that I work on. I
> see a lot of other people doing something similar. That doesn't mean
> nothing slips through. I'm sure stuff does slip through. I would HOPE
> it's really obscure things only; but I fear it's also cases where the
> reporter didn't put the right people on the CC as well ;(
>...

There are bad bug reports, but not all bug reports are that bad.

What if the quality of the bug report is good and the submitter is 
responsive, and there's still zero reaction?

Let's make an example:

Since the first list I sent immediately after 2.6.19-rc1 was released, 
kernel Bugzilla #7255 is part of my list of 2.6.19-rc regressions but 
has gotten exactly zero developer responses.

What exactly were the mistakes of the submitter resulting in noone 
caring about Bugzilla #7255?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

