Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWADWQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWADWQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWADWQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:16:04 -0500
Received: from c-24-22-115-24.hsd1.or.comcast.net ([24.22.115.24]:29590 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750892AbWADWQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:16:03 -0500
Date: Wed, 4 Jan 2006 14:15:50 -0800
From: Greg KH <greg@kroah.com>
To: Nick Warne <nick@linicks.net>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104221549.GA13254@kroah.com>
References: <200601041710.37648.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk> <20060104220157.GB12778@kroah.com> <200601042210.47152.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601042210.47152.nick@linicks.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 10:10:47PM +0000, Nick Warne wrote:
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

That's because 2.6.15 is the latest stable release.

> OK, I suppose we are all capable of getting back to where we are on rebuilding 
> to latest 'stable', but there _is_ a missing link for somebody that doesn't 
> know - and I think backtracking patches isn't really the way to go if the 
> 'latest stable release' isn't catered for.

Um, it is, see my sentance above.  And if you want to download older
stable releases, you can jump to the proper directory, how long do you
want us to put older stable releases on the main page for?  :)

thanks,

greg k-h
