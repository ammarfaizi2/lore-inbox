Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbUKFHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbUKFHXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUKFHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:23:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36560 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261329AbUKFHXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:23:06 -0500
Date: Sat, 6 Nov 2004 08:24:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: Amit Shah <amitshah@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
Message-ID: <20041106072407.GA8285@elte.hu>
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu> <Pine.LNX.4.58.0411051210280.1237@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411051210280.1237@gradall.private.brainfood.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Heath <doogie@debian.org> wrote:

> Hunk #2 FAILED at 1545.
> 1 out of 2 hunks FAILED -- saving rejects to file mm/mmap.c.rej

ok, i fixed this in -V0.7.14. (but you can safely ignore the reject as
well.)

	Ingo
