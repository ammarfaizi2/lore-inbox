Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272866AbTG3Mb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272863AbTG3MaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:30:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55826 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272864AbTG3MaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:30:06 -0400
Date: Wed, 30 Jul 2003 14:27:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: Pavel Machek <pavel@ucw.cz>, Philip Graham Willoughby <pgw99@doc.ic.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730122711.GB4224@openzaurus.ucw.cz>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk> <20030729180005.GD2601@openzaurus.ucw.cz> <1059565549.27394.9.camel@vimes.crl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059565549.27394.9.camel@vimes.crl.hpl.hp.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd not said this is so pointless... handhelds tend to have "new mail" led for example.
> > Better question is why it is not integrated with input subsystem (similar to kbd leds).
> 
> I would have thought that leds are output?  Why would output devices be
> integrated into the input subsystem?
> 
> I do think that the Linux kernel should have a generic LED interface for
> devices that have them available as indicators.

Most keyboards have leds, some of them even "new mail" led, and input already handles those.
We have that interface already. Its badly named...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

