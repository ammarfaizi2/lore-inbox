Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVADW0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVADW0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVADWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:24:27 -0500
Received: from gprs215-128.eurotel.cz ([160.218.215.128]:20608 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262273AbVADVvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:51:35 -0500
Date: Tue, 4 Jan 2005 22:51:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: APM vs. ACPI, janitor wanted? [was Re: starting with 2.7]
Message-ID: <20050104215106.GA1586@elf.ucw.cz>
References: <20050104210424.GA1619@elf.ucw.cz> <Pine.LNX.3.96.1050104162400.3306B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1050104162400.3306B-100000@gatekeeper.tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Go ahead and become APM maintainer... APM needs some care. 
> > 
> > Problem is that ACPI needs driver model changes, and those affect APM
> > too. But noone is using APM these days, so when something breaks
> > there, it takes long to discover.
> 
> I wouldn't try it if ACPI support worked on my machines, and I really
> wasn't suggesting that effort should go into APM so much as refuting the
> notion that people could just use ACPI. I would rather see resources go
> into ACPI, as I would be delighted to move into the future.

Actually, *lot* of people are working on ACPI (like 4 full-time
equivalents or something). I'd be surprised if APM got tenth of that
work. So someone hacking APM one hour once a week could do quite a lot
of difference. Same ammount of work on ACPI is going to be barely
visible.
								Pavel
"It is easy to become APM hero" ;-).
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
