Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWADXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWADXPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWADXPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:15:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:16281 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751823AbWADXO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:14:59 -0500
Date: Wed, 4 Jan 2006 15:13:30 -0800
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Message-ID: <20060104231330.GD14788@kroah.com>
References: <200601041710.37648.nick@linicks.net> <Pine.LNX.4.58.0601041415510.19134@shark.he.net> <20060104223101.GB13799@kroah.com> <200601042258.24888.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601042258.24888.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 10:58:24PM +0000, Alistair John Strachan wrote:
> On Wednesday 04 January 2006 22:31, Greg KH wrote:
> [snip]
> > > >
> > > > The issue I hit was we have a 'latest stable kernel release 2.6.14.5'
> > > > and under it a 'the latest stable kernel' (or words to that effect) on
> > > > kernel.org.
> > > >
> > > > Then when 2.6.15 came out, that was it!  No patch for the 'latest
> > > > stable kernel release 2.6.14.5'.  It was GONE!
> > >
> > > Yes, I brought this up a couple of weeks ago, but I was told
> > > that I was wrong (in some such words).
> > > I agree that it needs to be fixed.
> >
> > How would you suggest that it be fixed?
> 
> It's difficult, but perhaps providing a link to the latest "stable team" 
> release in addition to Linus's release would solve the problem.

But what happens when we release a 2.6.14.y release and a 2.6.15.y
release at the same time (as people have requested this in previous
threads...)?  What would show up where?

thanks,

greg k-h
