Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVBUSe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVBUSe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVBUSe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:34:29 -0500
Received: from levante.wiggy.net ([195.85.225.139]:40649 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262072AbVBUSeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:34:19 -0500
Date: Mon, 21 Feb 2005 19:34:13 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: James Simmons <jsimmons@pentafluge.infradead.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050221183413.GG6722@wiggy.net>
Mail-Followup-To: James Simmons <jsimmons@www.infradead.org>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
	Oliver Neukum <oliver@neukum.org>,
	Richard Purdie <rpurdie@rpsys.net>,
	James Simmons <jsimmons@pentafluge.infradead.org>,
	Adrian Bunk <bunk@stusta.de>,
	Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz> <200502182158.34910.dtor_core@ameritech.net> <1108794519.4098.24.camel@desktop.cunningham.myip.net.au> <Pine.LNX.4.56.0502211810360.13423@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0502211810360.13423@pentafluge.infradead.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously James Simmons wrote:
> Checkout DBUS. Its very nice. 

D-BUS is already userspace. netlink however is a nice transport system
and there are several existing tools that pass messages from netlink
onto D-BUS.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
