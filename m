Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbTBKKwn>; Tue, 11 Feb 2003 05:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTBKKvy>; Tue, 11 Feb 2003 05:51:54 -0500
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267507AbTBKKuj>;
	Tue, 11 Feb 2003 05:50:39 -0500
Date: Mon, 10 Feb 2003 18:22:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard hangs..
Message-ID: <20030210172239.GE443@elf.ucw.cz>
References: <Pine.LNX.4.44.0302100225160.26242-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302100225160.26242-100000@pianoman.cluster.toy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm having an issue with my laptop.. the same issue i've had for since I
> baught it..  Under linux the mouse (synaptics touchpad) and/or keyboard
> will suddenly lock.  All input stops.  I can telnet in and shutdown
> cleanly, but that doesn't help recover that I've got on my screen in X (or
> the console).
> 
> Hardware: HP n5430 laptop, synaptics touchpad, trident XP graphics,
> standard low-end laptop.
> 
> Here's the really odd part.  When it happens, if i notice quickly enough
> and hit the power switch on my laptop for just a split second (not the 5
> seconds to power off).. it sometimes comes back!  It's happened twice
> while typing this email in pine using a text console (no X, no mouse).
> But if I wait too long (a few seconds)...no matter how many times i nudge
> the power switch, it never comes back.  Sometimes it's more frequent then
> others.. sometimes I'll go for days/weeks without seeing it.

Strange.. I have something very similar on hp omnibook xe3 here,
except that:

1) I do not think it responds to the net when hung

2) it *allways* recovers after power button

3) it seems to only happen in 2.5.X here, maybe it has something to do
with ACPI?

> The behavior is a little different recently though with the 2.5 series.
> Now, sometimes when it comes back, i get the character i was typing
> repeated (as if a key was stuck) until i hit another key.  This change
> could be related to the new i8042 changes in 2.5, I'm not sure.

Mine remembers up to few keystrokes I was typing...

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
