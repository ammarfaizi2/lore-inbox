Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbRGHRhE>; Sun, 8 Jul 2001 13:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRGHRgy>; Sun, 8 Jul 2001 13:36:54 -0400
Received: from [194.213.32.142] ([194.213.32.142]:34052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266940AbRGHRgq>;
	Sun, 8 Jul 2001 13:36:46 -0400
Date: Sat, 30 Jun 2001 10:52:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Gerhard Mack <gmack@innerfire.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Patrick Dreker <patrick@dreker.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010630105223.A36@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10106281224250.26067-100000@innerfire.net> <3B3B8601.2FEA031E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B3B8601.2FEA031E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jun 28, 2001 at 03:31:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> FWIW I find usb and parport messages exceptionally verbose, but some of

USB was bad, but should get better in 2.4.6. I hate that ugly verbosity,
and will try to kill it in USB case.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

