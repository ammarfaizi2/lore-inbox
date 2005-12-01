Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVLAMaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVLAMaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVLAMaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:30:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52932 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932186AbVLAMaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:30:00 -0500
Date: Thu, 1 Dec 2005 13:28:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Sharp power management: split into sharpsl-dependend and generic parts
Message-ID: <20051201122820.GD2970@elf.ucw.cz>
References: <20051121224706.GA12906@elf.ucw.cz> <1133214624.8673.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133214624.8673.23.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This splits sharpsl_pm.c into sharpsl_pm.c and
> > sharp_pm.c. sharpsl_pm.c contains stuff that is shared between spitz
> > and corgi, sharp_pm.c contains more widely usable code. I'd like
> > something like this to be eventually merged... [Of course, I'll
> > cleanup #ifdef COLLIE's, I did not realize some were still pending.]
> 
> As discussed, I've made a version of this available as:
> 
> http://www.rpsys.net/openzaurus/patches/sharpsl_pm_move-r0.patch

Looks good to me, thanks.
								Pavel

-- 
Thanks, Sharp!
