Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVBUSLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVBUSLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVBUSLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:11:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58322 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262059AbVBUSL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:11:28 -0500
Date: Mon, 21 Feb 2005 18:11:06 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Vojtech Pavlik <vojtech@suse.cz>, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
In-Reply-To: <1108794519.4098.24.camel@desktop.cunningham.myip.net.au>
Message-ID: <Pine.LNX.4.56.0502211810360.13423@pentafluge.infradead.org>
References: <047401c515bb$437b5130$0f01a8c0@max>  <20050218213801.GA3544@ucw.cz>
 <20050218233148.GA1628@elf.ucw.cz>  <200502182158.34910.dtor_core@ameritech.net>
 <1108794519.4098.24.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I think we need a generic way of delivering system status changes to
> > userspace. Something like acpid but bigger than that, something not
> > so heavily oriented on ACPI. I wonder if that kernel connector patch
> > should be looked at.
> 
> Absolutely. I've been thinking about this too, but haven't yet found the
> time to put it down on paper/email yet.

Checkout DBUS. Its very nice. 
