Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUJIFKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUJIFKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUJIFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:10:30 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:21406 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266481AbUJIFKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:10:25 -0400
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <1097297824.1442.132.camel@krustophenia.net>
Message-ID: <cone.1097298596.537768.1810.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?B?Sy5SLg==?= Foley <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: voluntary-preempt-2.6.9-rc3-mm3-T3
Date: Sat, 09 Oct 2004 15:09:56 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell writes:

> On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
>> i've released the -T3 VP patch:
>> 
>>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>> 
> 
> With VP and PREEMPT in general, does the scheduler always run the
> highest priority process, or do we only preempt if a SCHED_FIFO process
> is runnable?

Always the highest priority runnable.

Cheers,
Con

