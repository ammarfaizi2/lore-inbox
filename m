Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbUKKP2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbUKKP2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbUKKP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:26:12 -0500
Received: from mail8.spymac.net ([195.225.149.8]:5031 "EHLO mail8")
	by vger.kernel.org with ESMTP id S262243AbUKKPZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:25:12 -0500
Message-ID: <41939263.4020004@spymac.com>
Date: Thu, 11 Nov 2004 17:25:07 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <41938D60.4070802@spymac.com> <20041111160819.GA26184@elte.hu> <20041111161235.GA26582@elte.hu>
In-Reply-To: <20041111161235.GA26582@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Ingo Molnar <mingo@elte.hu> wrote:
>
>  
>
>>* Gunther Persoons <gunther_persoons@spymac.com> wrote:
>>
>>    
>>
>>>Got 2 times a hard lock up with this one. Happened while i was typing
>>>something and downloading both after 15-20 minutes.
>>>      
>>>
>>.config?
>>    
>>
>
>just in case you are using UP-IOAPIC, could you enable CONFIG_SMP (even
>if you are running an UP box) and see whether the lockup goes away? 
>  
>
Ok. Going to build a new kernel.

>Which was the last -RT kernel that you tried that didnt lock up in this
>fashion?
>  
>
V0.7.24.

>	Ingo
>
>  
>

