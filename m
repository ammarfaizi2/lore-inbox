Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWADWQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWADWQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWADWQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:16:41 -0500
Received: from xenotime.net ([66.160.160.81]:36297 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750910AbWADWQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:16:40 -0500
Date: Wed, 4 Jan 2006 14:16:37 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Nick Warne <nick@linicks.net>
cc: Greg KH <greg@kroah.com>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
In-Reply-To: <200601042210.47152.nick@linicks.net>
Message-ID: <Pine.LNX.4.58.0601041415510.19134@shark.he.net>
References: <200601041710.37648.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk>
 <20060104220157.GB12778@kroah.com> <200601042210.47152.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Nick Warne wrote:

> On Wednesday 04 January 2006 22:01, Greg KH wrote:
>
> > > > > Nick's right, both are provided automatically by kernel.org.
> > > >
> > > > Anyway, I started from scratch - 2.6.14, patched to 2.6.15 and then
> > > > make oldconfig etc.
> > > >
> > > > I think there needs to be a way out of this that is easily discernible
> > > > - it does get confusing sometimes with all the patches flying around on
> > > > a 'stable release'.
> > >
> > > It's documented in the kernel.
> > >
> > > There's something in the kernel.org FAQ there about -rc kernels, but it
> > > might be better to generalise this for stable releases. Added hpa to CC.
> >
> > What do you mean, "generalize" this?  Where else could we document it
> > better?
>
> The issue I hit was we have a 'latest stable kernel release 2.6.14.5' and
> under it a 'the latest stable kernel' (or words to that effect) on
> kernel.org.
>
> Then when 2.6.15 came out, that was it!  No patch for the 'latest stable
> kernel release 2.6.14.5'.  It was GONE!

Yes, I brought this up a couple of weeks ago, but I was told
that I was wrong (in some such words).
I agree that it needs to be fixed.

> OK, I suppose we are all capable of getting back to where we are on rebuilding
> to latest 'stable', but there _is_ a missing link for somebody that doesn't
> know - and I think backtracking patches isn't really the way to go if the
> 'latest stable release' isn't catered for.

-- 
~Randy
