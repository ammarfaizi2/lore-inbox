Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTKTNIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 08:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbTKTNHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 08:07:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19942 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261774AbTKTNHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 08:07:08 -0500
Date: Thu, 20 Nov 2003 13:52:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] document that udev isn't yet ready (fwd)
Message-ID: <20031120125228.GC432@openzaurus.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119232651.GA22676@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hm, with the 006 release, what do you find lacking in udev?
> > > 
> > 
> > I am guessing its more driver support, etc.  Input devices for
> > instance do not seem to have any sysfs support yet,
> 
> Yes, we do need better driver support.  But that's nothing that udev
> itself can do :)
> 
> I have a number of patches pending for 2.6.1 that will add more driver
> support for sysfs.
> 
What drivers did you convert? sysfs-for-inputs would
be *very* welcome.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

