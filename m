Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVBUWwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVBUWwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVBUWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:52:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62679 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262171AbVBUWws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:52:48 -0500
Date: Mon, 21 Feb 2005 22:52:41 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Wichert Akkerman <wichert@wiggy.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>, Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
In-Reply-To: <1109026236.8475.2.camel@desktop.cunningham.myip.net.au>
Message-ID: <Pine.LNX.4.56.0502212251540.17645@pentafluge.infradead.org>
References: <047401c515bb$437b5130$0f01a8c0@max>  <20050218213801.GA3544@ucw.cz>
 <20050218233148.GA1628@elf.ucw.cz>  <200502182158.34910.dtor_core@ameritech.net>
  <1108794519.4098.24.camel@desktop.cunningham.myip.net.au> 
 <Pine.LNX.4.56.0502211810360.13423@pentafluge.infradead.org> 
 <20050221183413.GG6722@wiggy.net>  <Pine.LNX.4.56.0502212137090.16017@pentafluge.infradead.org>
 <1109026236.8475.2.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > Checkout DBUS. Its very nice. 
> > > 
> > > D-BUS is already userspace. netlink however is a nice transport system
> > > and there are several existing tools that pass messages from netlink
> > > onto D-BUS.
> > 
> > That is what I mean. We already have a userspace component.
> 
> I like the look of it!
> 
> Looks like some work has already been done on getting kernel events out
> to dbus, too. Found this email:
> http://mail.gnome.org/archives/utopia-list/2004-July/msg00031.html
> 
> Think I'll contact RML and Kay to see what the current state of play is.

DBUS isthe future. I just wish they had  programing howto for the average 
joe to write apps for it.

