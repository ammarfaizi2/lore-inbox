Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWADXnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWADXnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWADXnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:43:00 -0500
Received: from xenotime.net ([66.160.160.81]:7115 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750741AbWADXnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:43:00 -0500
Date: Wed, 4 Jan 2006 15:42:57 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Greg KH <greg@kroah.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
In-Reply-To: <20060104234106.GB15724@kroah.com>
Message-ID: <Pine.LNX.4.58.0601041542280.19134@shark.he.net>
References: <200601041710.37648.nick@linicks.net> <200601042258.24888.s0348365@sms.ed.ac.uk>
 <20060104231330.GD14788@kroah.com> <200601042328.15528.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.58.0601041530000.19134@shark.he.net> <20060104234106.GB15724@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Greg KH wrote:

> On Wed, Jan 04, 2006 at 03:31:01PM -0800, Randy.Dunlap wrote:
> > On Wed, 4 Jan 2006, Alistair John Strachan wrote:
> >
> > > On Wednesday 04 January 2006 23:13, Greg KH wrote:
> > > > On Wed, Jan 04, 2006 at 10:58:24PM +0000, Alistair John Strachan wrote:
> > > > > On Wednesday 04 January 2006 22:31, Greg KH wrote:
> > > > > [snip]
> > > > >
> > > > > > > > The issue I hit was we have a 'latest stable kernel release
> > > > > > > > 2.6.14.5' and under it a 'the latest stable kernel' (or words to
> > > > > > > > that effect) on kernel.org.
> > > > > > > >
> > > > > > > > Then when 2.6.15 came out, that was it!  No patch for the 'latest
> > > > > > > > stable kernel release 2.6.14.5'.  It was GONE!
> > > > > > >
> > > > > > > Yes, I brought this up a couple of weeks ago, but I was told
> > > > > > > that I was wrong (in some such words).
> > > > > > > I agree that it needs to be fixed.
> > > > > >
> > > > > > How would you suggest that it be fixed?
> > > > >
> > > > > It's difficult, but perhaps providing a link to the latest "stable team"
> > > > > release in addition to Linus's release would solve the problem.
> > > >
> > > > But what happens when we release a 2.6.14.y release and a 2.6.15.y
> > > > release at the same time (as people have requested this in previous
> > > > threads...)?  What would show up where?
> > >
> > > You're right, it's complicated. In that case I'd still opt for showing
> > > 2.6.15.y, as the vast majority of people manually installing vanilla kernels
> > > will either be on the latest-ish kernel, or have a clue about what they're
> > > doing (who doesn't know the ftp URL off by heart now).
> >
> > I agree.  I think that one previous -stable patch version should always
> > be listed there, even if we think that 2.6.N is stable.  :)
>
> I don't at all.  If we do that, people will assume that they need to
> wait till 2.6.N.1 before trying that kernel (as it wouldn't be "stable"
> otherwise.)  So no one will test it, to really generate the bug reports
> that we need to get to that .1 release.
>
> Or should we just throw out a .1 release with the first simple patch
> that comes along just to make the kernel.org page update properly?  I
> don't think so...

and the circle continues.

You are reading too much PR.  8:)

-- 
~Randy
