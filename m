Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266294AbUFPOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUFPOMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUFPOLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:11:32 -0400
Received: from pop.gmx.de ([213.165.64.20]:13245 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263932AbUFPOLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:11:22 -0400
X-Authenticated: #4512188
Message-ID: <40D05506.3050302@gmx.de>
Date: Wed, 16 Jun 2004 16:11:18 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040604)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
References: <1087333441.40cf6441277b5@vds.kolivas.org> <40D04439.5080100@gmx.de> <40D044BA.4080009@kolivas.org> <40D04717.9080701@gmx.de> <40D047C4.30209@kolivas.org>
In-Reply-To: <40D047C4.30209@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Prakash K. Cheemplavam wrote:
> 
>> Con Kolivas wrote:
>> >> Prakash K. Cheemplavam wrote:
>>
>>>>>> Con Kolivas wrote:
>>>>>>
>>>>>>>> Here is an updated version of the staircase scheduler. I've been 
>>>>>
>>>>> trying to hold
>>>>> off for 2.6.7 final but this has not been announced yet. Here is a 
>>>>> brief update
>>>>> summary.
>>>>
>>>> Hi, does this resolve the issue with ut2004? (Or is another setting 
>>>> for it needed?) I haven't tried myself, but others reported that 
>>>> setting interactive to 0 didn't help, nor giving ut2004 more 
>>>> priority via (re)nice.
>>>
>>> Good question. I don't own UT2004 so I was hoping a tester might 
>>> enlighten me.
>>
>> Well you can download the Demo for free...
> 
> 
> Not everyone has hardware (including graphic cards) that are capable of 
> running it.

Ok, yes, that's true. When I got time, I'll test your scheduler again 
and ask you what I should try.

Prakash
