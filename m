Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTJUDAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 23:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTJUC7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:59:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:62879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262859AbTJUC5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:57:40 -0400
Date: Mon, 20 Oct 2003 19:43:22 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
Subject: Re: [ANNOUNCE] udev 003 release
Message-ID: <20031021024322.GA29643@kroah.com>
References: <20031017055652.GA7712@kroah.com> <200310171757.h9HHvGiY006997@orion.dwf.com> <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com> <1066696767.10221.164.camel@nosferatu.lan> <20031021005025.GA28269@kroah.com> <1066698679.10221.178.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066698679.10221.178.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 03:11:19AM +0200, Martin Schlemmer wrote:
> On Tue, 2003-10-21 at 02:50, Greg KH wrote:
> > > 1)  Is it possible to maintain naming of tarball/version ?  Meaning,
> > >     say we forget about the 003 version, could the next be 0.4, or even
> > >     0.3.1 or whatever ?  Just changing makes trying to keep packages
> > >     sane a hassle.  Thanks :)
> > 
> > The naming will be consistant from now on.  Next release will be 004,
> > followed by 005, and so on.  Remember, version numbers mean nothing :)
> > 
> 
> Well, if you had an 0.2 already, 003 sorda comes and screw the pooch 
> (if trying to work with a package manager - although it seems we are
> OK with ours seeing 003 as the later) :)

Exactly, switching this early is fine by all of the package managers
I've looked at.  Does this mean you have a udev gentoo package
somewhere?

> > Of course you need a kernel patch for the sound class that is only
> > available in my kernel tree right now for sound devices to work with
> > udev...
> > 
> 
> Need help testing ? :) (Yes, I am a lazy bastard, and a patch against
> test8 would help if you needed the testing)

I need to get these class patches out sometime soon, been too busy
lately...

greg k-h
