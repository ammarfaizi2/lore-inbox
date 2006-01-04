Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965291AbWADWbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965291AbWADWbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWADWbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:31:24 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:43442 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S965291AbWADWbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:31:13 -0500
Date: Wed, 4 Jan 2006 14:31:01 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Nick Warne <nick@linicks.net>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104223101.GB13799@kroah.com>
References: <200601041710.37648.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk> <20060104220157.GB12778@kroah.com> <200601042210.47152.nick@linicks.net> <Pine.LNX.4.58.0601041415510.19134@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601041415510.19134@shark.he.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 02:16:37PM -0800, Randy.Dunlap wrote:
> On Wed, 4 Jan 2006, Nick Warne wrote:
> 
> > On Wednesday 04 January 2006 22:01, Greg KH wrote:
> >
> > > > > > Nick's right, both are provided automatically by kernel.org.
> > > > >
> > > > > Anyway, I started from scratch - 2.6.14, patched to 2.6.15 and then
> > > > > make oldconfig etc.
> > > > >
> > > > > I think there needs to be a way out of this that is easily discernible
> > > > > - it does get confusing sometimes with all the patches flying around on
> > > > > a 'stable release'.
> > > >
> > > > It's documented in the kernel.
> > > >
> > > > There's something in the kernel.org FAQ there about -rc kernels, but it
> > > > might be better to generalise this for stable releases. Added hpa to CC.
> > >
> > > What do you mean, "generalize" this?  Where else could we document it
> > > better?
> >
> > The issue I hit was we have a 'latest stable kernel release 2.6.14.5' and
> > under it a 'the latest stable kernel' (or words to that effect) on
> > kernel.org.
> >
> > Then when 2.6.15 came out, that was it!  No patch for the 'latest stable
> > kernel release 2.6.14.5'.  It was GONE!
> 
> Yes, I brought this up a couple of weeks ago, but I was told
> that I was wrong (in some such words).
> I agree that it needs to be fixed.

How would you suggest that it be fixed?

thanks,

greg k-h
