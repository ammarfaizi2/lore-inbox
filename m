Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbUKPRk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUKPRk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUKPRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:40:29 -0500
Received: from mail4.utc.com ([192.249.46.193]:45015 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262068AbUKPRkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:40:24 -0500
Message-ID: <419A3B6B.4090902@cybsft.com>
Date: Tue, 16 Nov 2004 11:39:55 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark_H_Johnson@raytheon.com
CC: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
References: <OF9912C2F0.D5088A51-ON86256F4E.005951F3-86256F4E.0059520E@raytheon.com>
In-Reply-To: <OF9912C2F0.D5088A51-ON86256F4E.005951F3-86256F4E.0059520E@raytheon.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@raytheon.com wrote:
>>From what I can tell, it was attempting to test the NMI watchdog
> 
>>when it failed.
> 
> 
> Confirmed, clean boot when I removed
>   nmi_watchdog=1 profile=2
> from the boot parameters. Will be doing some tests without it.
> 
>    --Mark
> 
> 
I have no such boot parameters and I still couldn't get it to boot on my 
SMP workstation at the office.

kr
