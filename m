Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVF1Dse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVF1Dse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVF1Dq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:46:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:44724 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262501AbVF1Dqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:46:39 -0400
Date: Mon, 27 Jun 2005 20:36:36 -0700
From: Greg KH <greg@kroah.com>
To: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628033636.GA32642@kroah.com>
References: <20050624081808.GA26174@kroah.com> <20050625221516.GD14426@waste.org> <20050625234305.GA11282@kroah.com> <20050626092320.B14862@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626092320.B14862@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 09:23:20AM +0100, Russell King wrote:
> On Sat, Jun 25, 2005 at 04:43:05PM -0700, Greg KH wrote:
> > > What we really need is a short HOWTO that covers:
> > > 
> > > - Do you really need a dynamic /dev?
> > > - How to embed a static /dev in your embedded kernel with initramfs
> > > - How to add a dynamic /dev to your kernel with udev
> > 
> > Yes, I'm going to start working with some of the people who really know
> > this stuff (the distro developers who make the whole dynamic boot and
> > early boot process work correctly) and we will hash out a coheirant
> > future together, and document it all really well.
> 
> I hope "distro developers" will include folk like Open Embedded developers
> rather than just targetting the Red Hat's, Debians and SuSE's ?

Of course, if there are any people you can think of that I should
contact about this, in the embedded world, please give me their
names/email addresses (offlist if you wish.)

thanks,

greg k-h
