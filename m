Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTLEAF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLEAFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:05:25 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:27265 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263763AbTLEAFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:05:12 -0500
Date: Fri, 5 Dec 2003 01:06:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software suspend under -test10.
Message-ID: <20031205000600.GA408@elf.ucw.cz>
References: <200312021413.15131.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312021413.15131.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Using the /sys/power/state = disk method, here's what's different:
> 
> During suspend, the power to the screen gets shut off fairly early on so I 
> can't see what suspend is doing.  It does continue and suspend, though.
> 
> On resume, I need to call hwclock --hctosys to update the system clock.  I 
> thought that had been fixed, but it's not in.  (Maybe it's in -mm?)

It should be in Patrick's patches...
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
