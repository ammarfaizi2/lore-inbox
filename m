Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWE3ROF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWE3ROF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWE3ROF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:14:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23759 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932347AbWE3ROB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:14:01 -0400
Date: Tue, 30 May 2006 10:11:30 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Device Driver Kit available
Message-ID: <20060530171130.GD7818@kroah.com>
References: <20060524232900.GA18408@kroah.com> <35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com> <20060529214306.GA10875@kroah.com> <20060529162534.a59e382b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529162534.a59e382b.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 04:25:34PM -0700, Randy.Dunlap wrote:
> On Mon, 29 May 2006 14:43:06 -0700 Greg KH wrote:
> 
> > On Sun, May 28, 2006 at 10:29:12AM +0100, Jon Masters wrote:
> > > On 5/25/06, Greg KH <greg@kroah.com> wrote:
> > > Random ideas:
> > > 
> > > * Bootable Damn Small Linux (DSL) or similar.
> > 
> > No, I don't want to get into the distro business.  Already do enough of
> > that work at my day job :)
> > 
> > > * cached LXR (obviously with reduced function).
> > 
> > LXR doesn't look to run without a web server backend, which makes this
> > very limited.  I'm trying to get jsFind working properly, and then index
> > the whole kernel source tree with it.  If that happens, we will get a
> > basic search engine, but without cross references.
> > 
> > Unless someone knows how to do this another way?
> 
> I've never used jsFind.  Is it much better than cscope?
> or just what are you trying to provide?

jsFind is a search engine for web pages that works cross-platform
directly from a cdrom.  It does not require you to install any program
on your machine, which would allow you to access and search the DDK from
any operating system.

As such, it is very different from cscope.

thanks,

greg k-h
