Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbRGSUI5>; Thu, 19 Jul 2001 16:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRGSUIr>; Thu, 19 Jul 2001 16:08:47 -0400
Received: from [194.213.32.142] ([194.213.32.142]:1540 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S265972AbRGSUIm>;
	Thu, 19 Jul 2001 16:08:42 -0400
Date: Fri, 13 Jul 2001 11:47:17 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.6 Configure.help incomplete :-(
Message-ID: <20010713114716.A432@toy.ucw.cz>
In-Reply-To: <20010705123649.B16700@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010705123649.B16700@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Jul 05, 2001 at 12:36:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

> There are still a lot of help texts missing from Configure.help,
> CONFIG_AIC7XXXX_BUILD_FIRMWARE to name just one example.
> 
> I'm pretty annoyed by RELEASE versions that don't have all options
> documented. If a module doesn't come with proper documentation for all
> its options, drop it. 

Ugh?

Configure.help is *very* minor thing, and it should not interfere with
kernel development. It will not corrupt your data. Will not make your
kernel unstable. Etc.

> How is a non-hacker supposed to configure the kernel if he doesn't even
> have the faintest clue about the options?

How many non-hackers have you seen confused by that particular option?

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

