Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVLLN43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVLLN43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 08:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVLLN42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 08:56:28 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:62112 "EHLO
	gandalf.stny.rr.com") by vger.kernel.org with ESMTP
	id S1751200AbVLLN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 08:56:28 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@kihontech.com>
To: tglx@linutronix.de
Cc: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>
In-Reply-To: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 08:56:21 -0500
Message-Id: <1134395781.5238.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas or Ingo,

Are these patches included in the 2.6.15-rc5-rt1?

Thanks,

-- Steve

On Mon, 2005-12-12 at 12:02 +0100, Thomas Gleixner wrote:
> The rebased version of the high resolution patches on top of the
> hrtimers base patch is available from the new project home:
> 
> http://www.tglx.de/projetcs/hrtimers
> 
> The current patch is available here:
> 
> http://www.tglx.de/projects/hrtimers/2.6.15-rc5/patch-2.6.15-rc5-hrt2.patch
> 
> along with the broken out series
> 
> http://www.tglx.de/projects/hrtimers/2.6.15-rc5/patch-2.6.15-rc5-hrt2.patches.tar.bz2
> 
> 
> Changes since the last 2.6.15-rc2-kthrt8 patch:
> 
> - rebased to hrtimers
> - newest Generic Timeofday patch from John Stultz
> - cleanups, bugfixes and improvements all over the place
> 
> Thanks to 
> - Roman Zippel for his help with ktime_t (see ktime.h), discussion and
> suggestions.
> - John Stultz for his timeofday work
> - all others who provided testing, help and suggestions 
> 
> 	tglx
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Steven Rostedt
Senior Programmer
Kihon Technologies
(607)786-4830

