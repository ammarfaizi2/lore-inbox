Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbTIPUHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbTIPUHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:07:05 -0400
Received: from gprs151-26.eurotel.cz ([160.218.151.26]:6787 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262508AbTIPUHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:07:03 -0400
Date: Tue, 16 Sep 2003 22:06:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Message-ID: <20030916200655.GG602@elf.ucw.cz>
References: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> w.r.t. power management:
>   - It doesn't poweroff anymore (screen contents are still there after the
>     powering down message)
>   - It doesn't reboot anymore (screen goes black, though)
>   - It accidentally suspended to RAM once while I was actively working on it (I
>     never managed to get suspend working, except for this `accident'). I didn't
>     see any messages about this in the kernel log.

It suspended to RAM... Did it also *resume* correctly?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
