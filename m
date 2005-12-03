Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVLCXhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVLCXhk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLCXhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:37:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:41116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932171AbVLCXhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:37:40 -0500
Date: Sat, 3 Dec 2005 15:37:20 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203233720.GA1604@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203230520.GJ25722@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 12:05:20AM +0100, Matthias Andree wrote:
> On Sat, 03 Dec 2005, Arjan van de Ven wrote:
> 
> > 
> > > Exactly that, and kernel interfaces going away just to annoy binary
> > > module providers also hurts third-party OSS modules, such as
> > > Fujitsu-Siemens's ServerView agents.
> > 
> > in kernel API never was and never will be stable, that's entirely
> > irrelevant and independent of the proposal at hand.
> 
> It's still an annoying side effect - is there a list of kernel functions
> removed, with version removed, and with replacement? I know of none, but
> then again I don't hack the kernel very often.

Both lwn.net and the kernelnewbies wiki are trying to track this.

thanks,

greg k-h
