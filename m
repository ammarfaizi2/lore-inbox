Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVBUWyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVBUWyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVBUWyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:54:54 -0500
Received: from levante.wiggy.net ([195.85.225.139]:11733 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262169AbVBUWyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:54:44 -0500
Date: Mon, 21 Feb 2005 23:54:41 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>, Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050221225441.GN6722@wiggy.net>
Mail-Followup-To: Nigel Cunningham <ncunningham@cyclades.com>,
	James Simmons <jsimmons@www.infradead.org>,
	James Simmons <jsimmons@pentafluge.infradead.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
	Oliver Neukum <oliver@neukum.org>,
	Richard Purdie <rpurdie@rpsys.net>, Adrian Bunk <bunk@stusta.de>,
	Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218213801.GA3544@ucw.cz> <20050218233148.GA1628@elf.ucw.cz> <200502182158.34910.dtor_core@ameritech.net> <1108794519.4098.24.camel@desktop.cunningham.myip.net.au> <Pine.LNX.4.56.0502211810360.13423@pentafluge.infradead.org> <20050221183413.GG6722@wiggy.net> <Pine.LNX.4.56.0502212137090.16017@pentafluge.infradead.org> <1109026236.8475.2.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109026236.8475.2.camel@desktop.cunningham.myip.net.au>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Nigel Cunningham wrote:
> Looks like some work has already been done on getting kernel events out
> to dbus, too. Found this email:
> http://mail.gnome.org/archives/utopia-list/2004-July/msg00031.html

Or http://lists.freedesktop.org/archives/dbus/2005-February/002170.html
or one of the few others that are there.

And the answer to all of those seems to be at HAL.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
