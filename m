Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWE2XW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWE2XW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWE2XW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:22:57 -0400
Received: from xenotime.net ([66.160.160.81]:41129 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932085AbWE2XW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:22:57 -0400
Date: Mon, 29 May 2006 16:25:34 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Device Driver Kit available
Message-Id: <20060529162534.a59e382b.rdunlap@xenotime.net>
In-Reply-To: <20060529214306.GA10875@kroah.com>
References: <20060524232900.GA18408@kroah.com>
	<35fb2e590605280229g76e75419h10717238e15e7347@mail.gmail.com>
	<20060529214306.GA10875@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 14:43:06 -0700 Greg KH wrote:

> On Sun, May 28, 2006 at 10:29:12AM +0100, Jon Masters wrote:
> > On 5/25/06, Greg KH <greg@kroah.com> wrote:
> > Random ideas:
> > 
> > * Bootable Damn Small Linux (DSL) or similar.
> 
> No, I don't want to get into the distro business.  Already do enough of
> that work at my day job :)
> 
> > * cached LXR (obviously with reduced function).
> 
> LXR doesn't look to run without a web server backend, which makes this
> very limited.  I'm trying to get jsFind working properly, and then index
> the whole kernel source tree with it.  If that happens, we will get a
> basic search engine, but without cross references.
> 
> Unless someone knows how to do this another way?

I've never used jsFind.  Is it much better than cscope?
or just what are you trying to provide?

---
~Randy
