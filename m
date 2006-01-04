Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWADWDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWADWDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWADWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:02:38 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:45447 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932214AbWADWCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:02:09 -0500
Date: Wed, 4 Jan 2006 14:01:57 -0800
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Nick Warne <nick@linicks.net>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104220157.GB12778@kroah.com>
References: <200601041710.37648.nick@linicks.net> <200601041834.23722.s0348365@sms.ed.ac.uk> <200601041953.15735.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601042010.36208.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 08:10:36PM +0000, Alistair John Strachan wrote:
> On Wednesday 04 January 2006 19:53, Nick Warne wrote:
> > On Wednesday 04 January 2006 18:34, Alistair John Strachan wrote:
> > > On Wednesday 04 January 2006 17:39, Nick Warne wrote:
> > > > On Wednesday 04 January 2006 17:36, Randy.Dunlap wrote:
> > > > > > I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
> > > > >
> > > > > and how did you do that?
> > > > > Noone supplies such incremental patches AFAIK.
> > > >
> > > > Yes, I got from kernel.org - I am _not_ that clever to devise my own
> > > > incremental patches, otherwise I wouldn't be asking stupid questions...
> > >
> > > Nick's right, both are provided automatically by kernel.org.
> >
> > Anyway, I started from scratch - 2.6.14, patched to 2.6.15 and then make
> > oldconfig etc.
> >
> > I think there needs to be a way out of this that is easily discernible - it
> > does get confusing sometimes with all the patches flying around on a
> > 'stable release'.
> 
> It's documented in the kernel.
> 
> There's something in the kernel.org FAQ there about -rc kernels, but it might 
> be better to generalise this for stable releases. Added hpa to CC.

What do you mean, "generalize" this?  Where else could we document it
better?

thanks,

greg k-h
