Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUHLOcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUHLOcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268579AbUHLOcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:32:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268578AbUHLOc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:32:28 -0400
Date: Wed, 11 Aug 2004 22:28:43 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040812012843.GA2122@dmt.cyclades>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com> <200408111004.02995.jbarnes@engr.sgi.com> <20040811172800.GB14979@kroah.com> <200408111102.10689.jbarnes@engr.sgi.com> <20040811181236.GD14979@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811181236.GD14979@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 11:12:36AM -0700, Greg KH wrote:
> On Wed, Aug 11, 2004 at 11:02:10AM -0700, Jesse Barnes wrote:
> > On Wednesday, August 11, 2004 10:28 am, Greg KH wrote:
> > > On Wed, Aug 11, 2004 at 10:04:02AM -0700, Jesse Barnes wrote:
> > > > On Friday, August 6, 2004 2:14 pm, Jon Smirl wrote:
> > > > > Please check the code out and give it some testing. It will probably
> > > > > needs some adjustment for other platforms.
> > > >
> > > > Jon, this works on my machine too.  Greg, if it looks ok can you pull it
> > > > in? And can you add:
> > > >
> > > >  * (C) Copyright 2004 Silicon Graphics, Inc.
> > > >  *       Jesse Barnes <jbarnes@sgi.com>
> > > >
> > > > to pci-sysfs.c if you do?
> > >
> > > Care to send me a new patch?  Oh, and that copyright line needs to look
> > > like:
> > > * Copyright (c) 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
> > >
> > > to make it legal, or so my lawyers say :)
> > 
> > But I'm not the copyright holder, Silicon Graphics is, I just wanted people to 
> > know who to harass if something breaks :).
> 
> That's fine.  It's the "Copyright (c) 2004" order and exact "(c)" that
> really matters, from what I have been told to do.

Greg,

That made me curious, what is the rationale behind 

(C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com> 

works and the previous suggested

(C) Copyright 2004 Silicon Graphics, Inc. 
	Jesse Barnes <jbarnes@sgi.com> 

doesnt? 

I know its a bit offtopic, but still, if you know the reason, would be
great to hear :) Bet others will also like to hear that. 

Thanks!




