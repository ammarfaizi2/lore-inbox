Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUBOPXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 10:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUBOPWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 10:22:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46303 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264981AbUBOPWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 10:22:21 -0500
Date: Sat, 14 Feb 2004 01:46:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Hayes <mike@aiinc.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spelling in 2.6.2
Message-ID: <20040214004643.GA470@openzaurus.ucw.cz>
References: <200402102009.i1AK91T20554@aiinc.aiinc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402102009.i1AK91T20554@aiinc.aiinc.ca>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Relax, this is not a spelling patch.
> 
> I was curious how fast spelling errors flow into the kernel, so I
> looked at the + lines in the 2.6.2 patch.  A few of the errors
> already existed, but most of them are new.  It turns out that there
> are around 200 new spelling errors in 2.6.2.
> 
> A "wether" (castrated goat) has appeared, along with a "Rusell" that

:-)

> Documentation/power/video.txt             carefull         careful            1

My fault, can you submit it through trivial?

> arch/i386/kernel/acpi/boot.c              recogznied       recognized         1
> arch/x86_64/kernel/acpi/boot.c            recogznied       recognized         1
> arch/x86_64/kernel/time.c                 everytime        every time         1
> arch/x86_64/kernel/time.c                 interuppts       interrupts         1

These too, please...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

