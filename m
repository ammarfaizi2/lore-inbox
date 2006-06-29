Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWF2RTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWF2RTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWF2RTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:19:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751072AbWF2RTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:19:13 -0400
Date: Thu, 29 Jun 2006 19:19:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michael Buesch <mb@bu3sch.de>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: radeonfb: corrupted screen on bootup
Message-ID: <20060629171852.GA3340@elf.ucw.cz>
References: <200606282118.27750.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.
> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)

I did not see the video (slow link here)... but if you turn off LCD
while keeping backlight on, you get very interesting "burning screen"
effect. I suspect that might be it. It will not damage anything.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
