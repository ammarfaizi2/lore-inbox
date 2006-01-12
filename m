Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWALCFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWALCFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWALCFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:05:24 -0500
Received: from smtp-out.google.com ([216.239.45.12]:1621 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964981AbWALCFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:05:23 -0500
Message-ID: <43C5B945.3000903@google.com>
Date: Wed, 11 Jan 2006 18:04:53 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <200601121218.47744.kernel@kolivas.org>
In-Reply-To: <200601121218.47744.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is a shot in the dark. We haven't confirmed 1. there is a problem 2. that 
> this is the problem nor 3. that this patch will fix the problem. I say we 
> wait for the results of 1. If the improved smp nice handling patch ends up 
> being responsible then it should not be merged upstream, and then this patch 
> can be tested on top.
> 
> Martin I know your work move has made it not your responsibility to test 
> backing out this change, but are you aware of anything being done to test 
> this hypothesis?

Yup, Andy queued the job ... just waiting for it to pop out the system

M.

