Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWENQYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWENQYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWENQYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:24:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23222 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751490AbWENQYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:24:53 -0400
Date: Sun, 14 May 2006 18:24:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: MMC drivers for 2.6 collie
Message-ID: <20060514162410.GG2438@elf.ucw.cz>
References: <20060514145325.GA3205@elf.ucw.cz> <1147619440.5531.167.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147619440.5531.167.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've tried searching sharp patches for MMC support, but could not find
> > it. Or should MMC_ARMMMCI work on collie?
> 
> Sharp's 2.4 MMC/SD drivers were binary only for all Zaurus models. Since
> we have documentation on the PXA, a 2.6 driver exists and works for all
> PXA models as we could guess the power controls and GPIOs. Collie
> (SA1100 based) used some kind of SPI interface through the LOCOMO chip
> (as far as I know) which we have no documentation on.

I thought we had completely open-source version at one point?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
