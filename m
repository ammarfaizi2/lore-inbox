Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVJDLo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVJDLo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 07:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVJDLo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 07:44:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63679 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932326AbVJDLo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 07:44:28 -0400
Date: Tue, 4 Oct 2005 13:44:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Timo =?iso-8859-1?Q?H=F6nig?= <thoenig@suse.de>
Subject: Re: thinkpad suspend to ram and backlight
Message-ID: <20051004114411.GC17458@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz> <43410149.9070007@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43410149.9070007@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> > video chips is not turned off, too). Unfortunately, backlight is not
> > turned even when lid is closed. I know some patches were floating
> > around to solve that... but I can't find them now. Any ideas?
> 
> Which framebuffer driver? Vesafb works for Timo, at least he did not
> complain lately ;-)

I really want radeonfb... I can try vesa, but long term this needs
solutions in radeon.
									Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
