Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUJYLNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUJYLNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUJYLNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:13:21 -0400
Received: from relay02.pair.com ([209.68.5.16]:40719 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261760AbUJYLNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:13:17 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417CDFCB.1010106@cybsft.com>
Date: Mon, 25 Oct 2004 06:13:15 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com> <20041025111046.GA3630@elte.hu>
In-Reply-To: <20041025111046.GA3630@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>>[ NOTE: there's one known bug in this release: selinux on one of my
>>>testsystems broke, it hangs during bootup. With CONFIG_SECURITY disabled
>>>it works fine. I'm working on the fix. So please keep CONFIG_SECURITY
>>>disabled for the time being. ]
>>>
>>
>>Does this include all models of security or just the selinux stuff?
> 
> 
> i have only tried selinux. (which is installed/enabled by default on FC3
> so it's easy for me to test on an out of box distro.)
> 
> 	Ingo
> 

Well I will know when it boots, or doesn't. :) I will report back when I 
know.

kr
