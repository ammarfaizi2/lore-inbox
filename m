Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTG1TSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270430AbTG1TSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:18:46 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:51341 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270384AbTG1TSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:18:45 -0400
Date: Mon, 28 Jul 2003 21:18:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: jari.ruusu@pp.inet.fi, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-ID: <20030728191834.GF572@elf.ucw.cz>
References: <20030728181408.GA499@elf.ucw.cz> <20030728182757.GA1793@win.tue.nl> <20030728183443.GC572@elf.ucw.cz> <20030728190039.GA1802@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728190039.GA1802@win.tue.nl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Plus I'm seeing some silent data corruption. It may be
> > > > swsusp or loop related
> > > 
> > > Loop is not stable at all. Unsuitable for daily use.
> > 
> > Ouch... I have my most important filesystem on loop. Time to go back
> > to 2.4.X? Or do you have some patches you want me to try?
> 
> [maybe an extra backup?]

Hmm, looks like I should do that.

> Jari's version of loop.c has always been solid.

Jari Ruusu? Okay, I'll test that.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
