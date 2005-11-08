Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVKHUxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVKHUxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVKHUxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:53:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54409 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965101AbVKHUxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:53:34 -0500
Date: Tue, 8 Nov 2005 21:53:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: MIPS PREEMPT_RT update..
Message-ID: <20051108205348.GA15964@elte.hu>
References: <436B85E1.1050103@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436B85E1.1050103@timesys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john cooper <john.cooper@timesys.com> wrote:

> Ingo,
>     Attached is a patch relative to 2.6.14-rc5-rt5
> which brings arch/mips up to date for PREEMPT_RT.
> This was derived from a similar patch I had for
> 2.6.13 but I'd assumed it was rather dated to apply
> to current work.  As it turned out both versions
> were quite close.

thanks - merged your patches, they will be in the next
-rt release.

	Ingo
