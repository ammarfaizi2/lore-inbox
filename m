Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUGXTc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUGXTc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 15:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGXTc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 15:32:59 -0400
Received: from av2-1-sn3.vrr.skanova.net ([81.228.9.107]:24205 "EHLO
	av2-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262329AbUGXTc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 15:32:58 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with snd_atiixp in 2.6.8-rc2 (and a workaround)
References: <m37jsv3j6a.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 24 Jul 2004 21:32:54 +0200
In-Reply-To: <m37jsv3j6a.fsf@telia.com>
Message-ID: <m3hdrx6w0p.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> The snd_atiixp module in the 2.6.8-rc2 kernel doesn't work on my
> Compaq Presario R3000 (R3057EA) computer. When I load the module,
> the kernel reports:
> 
> ACPI: PCI interrupt 0000:00:14.5[B] -> GSI 5 (level, low) -> IRQ 5
> ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -13

I see that this problem has already been fixed in the ALSA CVS, so
sorry for the noise, and thanks for the fix.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
