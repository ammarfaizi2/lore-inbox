Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUHKTTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUHKTTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268187AbUHKTTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:19:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:35782 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268183AbUHKTTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:19:05 -0400
Date: Wed, 11 Aug 2004 11:12:36 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040811181236.GD14979@kroah.com>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com> <200408111004.02995.jbarnes@engr.sgi.com> <20040811172800.GB14979@kroah.com> <200408111102.10689.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408111102.10689.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 11:02:10AM -0700, Jesse Barnes wrote:
> On Wednesday, August 11, 2004 10:28 am, Greg KH wrote:
> > On Wed, Aug 11, 2004 at 10:04:02AM -0700, Jesse Barnes wrote:
> > > On Friday, August 6, 2004 2:14 pm, Jon Smirl wrote:
> > > > Please check the code out and give it some testing. It will probably
> > > > needs some adjustment for other platforms.
> > >
> > > Jon, this works on my machine too.  Greg, if it looks ok can you pull it
> > > in? And can you add:
> > >
> > >  * (C) Copyright 2004 Silicon Graphics, Inc.
> > >  *       Jesse Barnes <jbarnes@sgi.com>
> > >
> > > to pci-sysfs.c if you do?
> >
> > Care to send me a new patch?  Oh, and that copyright line needs to look
> > like:
> > * Copyright (c) 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
> >
> > to make it legal, or so my lawyers say :)
> 
> But I'm not the copyright holder, Silicon Graphics is, I just wanted people to 
> know who to harass if something breaks :).

That's fine.  It's the "Copyright (c) 2004" order and exact "(c)" that
really matters, from what I have been told to do.

thanks,

greg k-h
