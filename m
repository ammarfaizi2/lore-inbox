Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVBUWtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVBUWtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVBUWtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:49:06 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:42723 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262166AbVBUWs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:48:59 -0500
Subject: Re: 2.6: drivers/input/power.c is never built
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: James Simmons <jsimmons@www.infradead.org>
Cc: Wichert Akkerman <wichert@wiggy.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>, Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0502212137090.16017@pentafluge.infradead.org>
References: <047401c515bb$437b5130$0f01a8c0@max>
	 <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz>
	 <200502182158.34910.dtor_core@ameritech.net>
	 <1108794519.4098.24.camel@desktop.cunningham.myip.net.au>
	 <Pine.LNX.4.56.0502211810360.13423@pentafluge.infradead.org>
	 <20050221183413.GG6722@wiggy.net>
	 <Pine.LNX.4.56.0502212137090.16017@pentafluge.infradead.org>
Content-Type: text/plain
Message-Id: <1109026236.8475.2.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 22 Feb 2005 09:50:36 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 08:37, James Simmons wrote:
> > Previously James Simmons wrote:
> > > Checkout DBUS. Its very nice. 
> > 
> > D-BUS is already userspace. netlink however is a nice transport system
> > and there are several existing tools that pass messages from netlink
> > onto D-BUS.
> 
> That is what I mean. We already have a userspace component.

I like the look of it!

Looks like some work has already been done on getting kernel events out
to dbus, too. Found this email:
http://mail.gnome.org/archives/utopia-list/2004-July/msg00031.html

Think I'll contact RML and Kay to see what the current state of play is.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

