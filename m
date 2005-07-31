Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVGaOKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVGaOKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 10:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVGaOJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 10:09:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56271 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261806AbVGaOIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 10:08:53 -0400
Date: Sun, 31 Jul 2005 16:08:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Brian Schau <brian@schau.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
Message-ID: <20050731140840.GK9418@elf.ucw.cz>
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz> <200507311459.00957.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507311459.00957.s0348365@sms.ed.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've attached a gzipped version of my Wireless Security Lock patch
> > > for v2.6.13-rc4.
> > > A Wireless Security Lock (WSL or weasel :-) is made up of two parts.
> > > One part is a receiver which you plug into any available USB port.
> > > The other part is a transmitter which at fixed intervals sends
> > > "ping packets".
> > > A "ping packet" usually consists of an ID and a flag telling if the
> > > transmitter has just been turned on.
> >
> > Idea is good... but why don't you simply use bluetooth (built into
> > many notebooks) and bluetooth-enabled phone?
> >
> > Probably could be done in userspace, too :-).
> 
> There's a script to this on the gentoo wiki via BlueZ.
> 
> http://gentoo-wiki.com/TIP_Bluetooth_Proximity_Monitor
> 
> I personally think the problem with this approach is that most phones have 
> bluetooth enabled explicitly as an option, it doesn't run all the time, or 
> default on. Primarily this is because bluetooth can drain your phone's 
> battery (though, I don't know by how much, if you're not actually 
> transferring data over it).

I have bluetooth turned on all the time, anyway, and it does not drain
battery that badly (standby time goes down 30%?).

> A CR2032 cell, in a specific piece of kit, is going to last for a lot longer 
> than a phone battery.

Well, you know... phones have *rechargable* batteries :-).

-- 
if you have sharp zaurus hardware you don't need... you know my address
