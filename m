Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273111AbTG3RpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273112AbTG3RpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:45:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35081 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S273111AbTG3Ro7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:44:59 -0400
Date: Wed, 30 Jul 2003 19:44:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730174457.GI10276@atrey.karlin.mff.cuni.cz>
References: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307301608.h6UG8YQJ000339@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But this kind of blinkenlights needed pretty fast LEDs. (At 486 time
> > I decided that parport on ISA is fast enough..)
> 
> I'll buy some LEDs and build a parallel port connected LED panel
> tomorrow...  Do you think the overhead of driving the LEDs would have
> too much of a negative effect on system performance?  If so, or if
> we

I'm not sure. At 486 days I was pretty sure it did not matter. These
days you might get 10% slowdown on some microbenchmark, or something
like that. I do not think it can slow down common tasks.

My construction of LED lights is extremely flaky, and I'm afraid of
burning printer port. At 486 days ports were expected to survive such
abuse. Not sure if todays EPP/wtf ports can handle that.
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
