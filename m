Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUL3Hkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUL3Hkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUL3Hkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:40:36 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:54210 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261563AbUL3Hka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:40:30 -0500
Message-ID: <41D3B121.1020600@kolivas.org>
Date: Thu, 30 Dec 2004 18:41:21 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org>	 <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak> <41D31373.1090801@kolivas.org>	 <4d8e3fd304122914466b42c632@mail.gmail.com>	 <41D33603.9060501@kolivas.org>	 <4d8e3fd304122923127167067c@mail.gmail.com>	 <20041229232028.055f8786.akpm@osdl.org> <4d8e3fd304122923362d823e34@mail.gmail.com>
In-Reply-To: <4d8e3fd304122923362d823e34@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> On Wed, 29 Dec 2004 23:20:28 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
>>Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>>
>>>Andrew,
>>> what's your plan for the staircase scheduler ?
>>
>>I have none, frankly.  I haven't seen any complaints about the current
>>scheduler.
>>
>>If someone can identify bad behaviour in the current scheduler which
>>staircase improves then please describe a tescase which the scheduler
>>developers can use to reproduce the situation.
>>
>>If, after that, we deem that the problem cannot be feasibly fixed within the
>>context of the current scheduler and that the problem is sufficiently
>>serious to justify wholesale replacement of the scheduler then sure,
>>staircase is an option.
> 
> 
> Your answer makes lot of sense.
> I think Con can explain the pro and cons of the staircase scheduler.

I agree fully with Andrew. I'm not going there while we have 2.6 forever 
development.

Cheers,
Con
