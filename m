Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbUKPSnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbUKPSnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 13:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUKPSnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 13:43:02 -0500
Received: from mail4.utc.com ([192.249.46.193]:24711 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262074AbUKPSlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 13:41:46 -0500
Message-ID: <419A49C4.2050305@cybsft.com>
Date: Tue, 16 Nov 2004 12:41:08 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <20041116184315.GA5492@elte.hu>
In-Reply-To: <20041116184315.GA5492@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:
> 
> 
>>Florian Schmidt <mista.tapas@gmx.net> wrote:
>>
>>
>>>ok, this new build still hangs at the same spot.
>>
>>Me too. The serial console output follows at the end. Will try a few
>>boot alternatives and let you know if I can get this to run.
>>>From what I can tell, it was attempting to test the NMI watchdog
>>when it failed.
> 
> 
> i've uploaded -5 with a fix in profile_tick() - does it boot fine for
> you now?
> 

This one boots for me now.

kr
