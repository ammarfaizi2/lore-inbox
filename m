Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUADUAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 15:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUADUAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 15:00:34 -0500
Received: from gprs214-164.eurotel.cz ([160.218.214.164]:62081 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262758AbUADUA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 15:00:28 -0500
Date: Sun, 4 Jan 2004 21:01:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Henne <metalhen@metalhen.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gaim problems in 2.6.0
Message-ID: <20040104200141.GE344@elf.ucw.cz>
References: <20040104172535.GA322@elf.ucw.cz> <3FF86F95.6040304@metalhen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF86F95.6040304@metalhen.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I'm having bad problems with gaim... When I run gaim, my machine tends
> >to freeze hard (no blinking leds). I'm running vesafb -> that should
> >rule out X problems. Machine is rather strange pre-production athlon64
> >noteook, but I'm running 32-bit (on 32-bit kernel), and I can run gaim
> >under 2.4.X kernel.
> >
> >[Ugh, I was running with kgdb, but I recall same problem before, too.]
> >
> >Does anyone have similar problem?
> 
> 
> It's not a so similiar problem or is it.
> I also have problems with gnome and freezing when using 2.6.0.
> With my old 2.4.20 kernel all is ok. My problems starts with 2.6.0 
> installation, which I needed for some hardware support. The new kernel 
> works well in console. Have no errors in `dmesg`, not even in syslog.
> If I setup a nework device and then also define a default route to my 
> gateway gnome seems to freeze with it's first network access.
> If I start net and then gnome, gnome needs to start over 20-30minutes 
> and still did not come up totally. If I setup network in a xterm in 
> gnome then gnome freezes after a short while, e.g. when starting mozilla.
> It is no hard freeze, it looks like gnome is running on a 1 Mhz PC or as 
> if it has time lack of several minutes.
> But it's only in grapical gnome. In a console I can surf with lynx.
> First I thougth it could be a gnome problem, but problems only come when 
> booting with 2.6.0

Seems like different issue, my machine is frozen, it does not ping
etc.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
