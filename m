Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVKZDMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVKZDMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVKZDMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:12:54 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:17585 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932684AbVKZDMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:12:54 -0500
Date: Sat, 26 Nov 2005 03:52:50 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Frank Sorenson <frank@tuxrocks.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>
Subject: Re: Mouse issues in -mm
Message-ID: <20051126025250.GA7000@stiffy.osknowledge.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <200511232226.44459.dtor_core@ameritech.net> <20051124094019.GA6788@stiffy.osknowledge.org> <200511251727.24630.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511251727.24630.dtor_core@ameritech.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-25 17:27:24 -0500]:

> On Thursday 24 November 2005 04:40, Marc Koschewski wrote:
> > I don't know why my touchpad is not listed. I have one and it perfectly
> > works with X (same pointer as the mouse which is a Microsoft USB Wheel Mouse'
> > attached to PS/2 using an appropriate adapter.
> >
> 
> [I dropped netdev list from CC...] 
> 
> You have a Dell Inspiron, right? On Inspirons (and Latitudes) mouse
> connected to external PS/2 port completely shadoes touchpad making
> it invisible to the kernel.

I knew that. But just forgot. ;) However, that was not the prob I had. Was just
wondering why it didn't show up in dmesg. I'll try to figure out, what made the
mouse go crazy in -mm series. 

Marc
