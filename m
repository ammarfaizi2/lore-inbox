Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265956AbSKBMpY>; Sat, 2 Nov 2002 07:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265950AbSKBMor>; Sat, 2 Nov 2002 07:44:47 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265955AbSKBMon>;
	Sat, 2 Nov 2002 07:44:43 -0500
Date: Fri, 1 Nov 2002 23:49:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [half-joke] Help - someone turned my machine into xt emulating 386 using bochs...
Message-ID: <20021101224946.GA137@elf.ucw.cz>
References: <20021101224514.GA126@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101224514.GA126@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> 
> Strange thing happened: My machine appeared to lock up. I tried to
> switch consoles, and nothing happened.... Up to now. Now I see
> consoles redrawing on vesab, at speed around 5 characters per
> second. [Yes, I can see letters being erased].
> 
> That's little slow for 300MHz celeron... I hope.
> 
> [Just before "incident", I turned of sharp zaurus; maybe it was
> connected using usbnet and now uhci is eating all the bandwidht?
> Anyone seen this before?]

Hmm, Now I see some messages (printed at 5 characters per second, will
press reset sooon.

events/0: page allocation failure. order:3, mode:0x20
drivers/usb/net/usbnet.c: usb0: kevent 2 may have been dropped
....

time for reset.

Hmm, I managed to press magic-s....
Syncing device ide0(3,1) ... pdflush: page allocation
failure. order:3, mode:0x20. [Hey, I can type messages as fast as they
are coming :-)]

time for *hard* reset I guess. [I wish I had videocamera for this.]
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
