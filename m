Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUH1Qvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUH1Qvx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUH1Qvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:51:53 -0400
Received: from relay.pair.com ([209.68.1.20]:43790 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267423AbUH1QuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:50:07 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <4130B7BD.5070801@cybsft.com>
Date: Sat, 28 Aug 2004 11:50:05 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q0
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu> <200408281818.28159.lkml@felipe-alfaro.com>
In-Reply-To: <200408281818.28159.lkml@felipe-alfaro.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Saturday 28 August 2004 14:03, Ingo Molnar wrote:
> 
> 
>>Similarly, there are 4 independent options for the .config:
>>CONFIG_PREEMPT, CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS and
>>CONFIG_PREEMPT_HARDIRQS. (In theory all of these options should compile
>>independently, but i've only tested all-enabled so far.)
> 
> 
> I must be missing something, but after applying diff-bk-040828-2.6.8.1.bz2 and 
> voluntary-preempt-2.6.9-rc1-bk4-Q1 on top of 2.6.8.1, I'm unable to find 
> neither CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS, nor 
> CONFIG_PREEMPT_HARDIRQS.
> 
> Any ideas are welcome.

Looks like all of these config options are missing from Q1 also. I was 
just looking myself.

kr
