Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281410AbRLACxe>; Fri, 30 Nov 2001 21:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281411AbRLACxZ>; Fri, 30 Nov 2001 21:53:25 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33530
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281410AbRLACxM>; Fri, 30 Nov 2001 21:53:12 -0500
Date: Fri, 30 Nov 2001 18:53:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Please tag tested releases of the 2.4.x kernel
Message-ID: <20011130185306.N504@mikef-linux.matchmail.com>
Mail-Followup-To: Ian Stirling <root@mauve.demon.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011130171017.L504@mikef-linux.matchmail.com> <200112010242.CAA12521@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112010242.CAA12521@mauve.demon.co.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 02:42:02AM +0000, Ian Stirling wrote:
> > 
> > On Sat, Dec 01, 2001 at 02:05:21AM +0100, willy tarreau wrote:
> > > I think that if even one tenth of the LKML
> > > subscribers rank their kernels at least once a week,
> > > we'll quickly see some stable and unusable kernels.
> > > 
> > 
> > I like this idea a lot.
> > 
> > Who can get such a system up and running?  Which web site?
> 
> I've proposed in the past a more extensive version of this.
> make register
> or similar.

I think I remember reading about that on kernel traffic...

> Which you run, and it grabs a snapshot of system setup, optionally
> with comments, and sends it in to a registry.
> You can then do 
> make comment
> and report issues.
> These would vary from "it crashes", to "my hard drive died/is dying"
> So we get information on systems, and some idea on which are reliable
> or not.
> 

I think people would have trouble with the versions of their apps being
reported.  Some people that is...

But, all something like this really needs is just to be blessed by someone
high in the kernel strata...

It doesn't actually *need* to be in the kernel though.  A user space package
would work great.  Run from a cron job, and report kernel version, and
optionally some other pertinent info.

Perodically, (monthly?) you would get an email asking you to fill out this
form and you'd get your registry with bug/status reports.

Even bigger, some sort of bug tracking system could be tied to this...

mf

> Last time some people disagreed with this obviously brilliant idea. :/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
