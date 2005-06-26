Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFZIXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFZIXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVFZIXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:23:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48139 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261456AbVFZIX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:23:27 -0400
Date: Sun, 26 Jun 2005 09:23:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050626092320.B14862@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050625221516.GD14426@waste.org> <20050625234305.GA11282@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050625234305.GA11282@kroah.com>; from greg@kroah.com on Sat, Jun 25, 2005 at 04:43:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 04:43:05PM -0700, Greg KH wrote:
> > What we really need is a short HOWTO that covers:
> > 
> > - Do you really need a dynamic /dev?
> > - How to embed a static /dev in your embedded kernel with initramfs
> > - How to add a dynamic /dev to your kernel with udev
> 
> Yes, I'm going to start working with some of the people who really know
> this stuff (the distro developers who make the whole dynamic boot and
> early boot process work correctly) and we will hash out a coheirant
> future together, and document it all really well.

I hope "distro developers" will include folk like Open Embedded developers
rather than just targetting the Red Hat's, Debians and SuSE's ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
