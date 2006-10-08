Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWJHVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJHVGU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWJHVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:06:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31655 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750784AbWJHVGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:06:20 -0400
Date: Sun, 8 Oct 2006 23:06:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061008210604.GC4152@elf.ucw.cz>
References: <200610071703.24599.david-b@pacbell.net> <Pine.LNX.4.44L0.0610072153510.15825-100000@netrider.rowland.org> <20061008193648.GA4042@elf.ucw.cz> <200610082157.17233.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610082157.17233.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-10-08 21:57:17, Oliver Neukum wrote:
> Am Sonntag, 8. Oktober 2006 21:36 schrieb Pavel Machek:
> > <AOL>Mee too</AOL>
> > 
> > Please, lets do few "autosuspend" things, and when we know how it
> > looks, we can think about doing something more advanced.
> 
> Very well, which drivers do you want first?

USB mouse would be very nice first step. Way less usb keyboards are
used, and that would be very nice second step.

If you want to try something different, autosuspending SATA can save
about 1W on my machine...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
