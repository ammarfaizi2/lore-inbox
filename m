Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVEaVnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVEaVnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVEaVnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:43:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47054 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261612AbVEaVm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:42:56 -0400
Date: Tue, 31 May 2005 23:42:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] 2.6.12-rc5
Message-ID: <20050531214238.GD9614@elf.ucw.cz>
References: <e032b5.beb8a3@family-bbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e032b5.beb8a3@family-bbs.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Computer: Cyrix MII processor, VIA VP3 chipset  e-machines 1999
> Kernels various, now 2.6.12-rc5
> 
> Observation: experimental ACPI sleep state, aka active standby,
> appears to work with mainline kernels in that it's possible to
> do
> # echo standby > /sys/power/state
> and have the system suspend. The computer's green led that's inset
> into the power button blinks slowly, then. And pressing the power button
> brings the system back, unless you wait too long. I'm not sure exactly
> how long, but I guess it may be roughly an hour or so until linux
> no longer returns when the power button is pressed briefly.

Did it work properly in any previous kernel?
								Pavel
