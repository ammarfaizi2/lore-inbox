Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbULOQeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbULOQeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbULOQeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:34:23 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:27834 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262382AbULOQeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:34:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Date: Wed, 15 Dec 2004 11:34:16 -0500
User-Agent: KMail/1.7
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>
References: <20041124101626.GA31788@elte.hu> <200412142138.10456.gene.heskett@verizon.net> <41C05733.8050100@cybsft.com>
In-Reply-To: <41C05733.8050100@cybsft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412151134.17738.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 10:34:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 10:24, K.R. Foley wrote:
>Gene Heskett wrote:
>> Did you see my comment about the later versions seeming to slow
>> seti a wee bit?  Other than that, I'm in love with this, the
>> whole system just plain feels better.  The only thing on my wish
>> list right now is to be able to shut tvtime up, it grows the
>> system log about a megabyte a minute with its missed read reports.
>> Or is it tvtime that needs help?
>
>Are you referring to the "Read missed before next interrupt"
> messages? If so, you can disable this by disabling the rtc
> histogram under: Device Drivers --> Character devices --> Real Time
> Clock Histogram Support.

Ok, thats building now.  Silly Q:  Can that be turned back on with a
setting in /proc or /sys?

>kr

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

