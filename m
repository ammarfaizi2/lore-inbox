Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWFPJp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWFPJp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWFPJp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:45:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34526 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750789AbWFPJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:45:56 -0400
Date: Fri, 16 Jun 2006 11:45:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: stephen@blacksapphire.com, benm@symmetric.co.nz,
       kernel list <linux-kernel@vger.kernel.org>, radek.stangel@gmsil.com
Subject: IPWireless 3G PCMCIA Network Driver and GPL
Message-ID: <20060616094516.GA3432@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to get "IPWireless 3G PCMCIA" to work under linux. There
are two problems:

* first, only available version is for 2.6.12, and fixes to make it
compile under 2.6.16 don't seem to be trivial

What is worse,

/*
 * IPWireless 3G PCMCIA Network Driver
 *
 *   by Stephen Blackheath <stephen@blacksapphire.com>,
 *      Ben Martel <benm@symmetric.co.nz>
 *
 * Copyrighted as follows:
 *   Copyright (C) 2004 by Symmetric Systems Ltd (NZ)
 */

...so I'm not even allowed to fix it. I believe that driver should be
GPLed -- it is unusable without pcmcia packages after all.

Can you clarify copyright situation? Does anyone have 2.6.16 version
by chance?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
