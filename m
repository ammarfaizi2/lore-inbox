Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVEWObg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVEWObg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVEWObd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:31:33 -0400
Received: from mail3.utc.com ([192.249.46.192]:12497 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S261595AbVEWOba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:31:30 -0400
Message-ID: <4291E913.6050700@cybsft.com>
Date: Mon, 23 May 2005 09:30:43 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Serge Noiraud <serge.noiraud@bull.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, dwalker@mvista.com,
       Joe King <atom_bomb@rocketmail.com>, ganzinger@mvista.com,
       Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <20050523082637.GA15696@elte.hu> <1116840848.1498.4.camel@ibiza.btsn.frna.bull.fr> <20050523112317.GA10579@elte.hu>
In-Reply-To: <20050523112317.GA10579@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> 
>>Le lun 23/05/2005 à 10:26, Ingo Molnar a écrit :
>>
>>>i have released the -V0.7.47-06 Real-Time Preemption patch, which can be 
>>>downloaded from the usual place:
>>>
>>>    http://redhat.com/~mingo/realtime-preempt/
>>
>>Cannot generate correctly for i686 :
> 
> 
> i've uploaded -07, does it work now?
> 
> 	Ingo

Ingo,

This one oopses on my dual P4 Xeon system before getting booted. I will 
dig into this when I get a free minute. I am knee deep in different 
alligators at the moment.

-- 
    kr
