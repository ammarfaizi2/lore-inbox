Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUDIK1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 06:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUDIK1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 06:27:48 -0400
Received: from gprs214-56.eurotel.cz ([160.218.214.56]:41089 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261162AbUDIK1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 06:27:47 -0400
Date: Fri, 9 Apr 2004 12:27:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Terhechte <ct@fdk-berlin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: powernow-k8: broken PSB
Message-ID: <20040409102730.GA13827@elf.ucw.cz>
References: <1080917249.7252.13.camel@asahi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080917249.7252.13.camel@asahi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm running Gentoo Linux on an Athlon 64 system (board is Asus 8KV SE
> Deluxe). I was getting the "BIOS error - no PSB" message when trying to
> "modprobe powernow-k8", so I upgraded to 2.6.5-rc3-mm4 which includes
> Pavel Machek's new powernow-k8 driver. Theoretically, it should be
> getting tables through ACPI and ignore the legacy PST/PSB tables, but
> I'm still getting the same error as before and inserting powernow-k8
> fails with this message:
> 
> FATAL: Error inserting powernow_k8
> (/lib/modules/2.6.5-rc3-mm4/kernel/arch/x86_64/cpufreq/powernow-k8.ko):
> No such device

Try putting it directly into kernel.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
