Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUEYSvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUEYSvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbUEYSvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:51:00 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:64459 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S265040AbUEYSuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:50:44 -0400
Message-ID: <40B395A0.2040002@timesys.com>
Date: Tue, 25 May 2004 14:51:12 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Bradley Hook <bhook@kssb.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085468812.2783.7.camel@laptop.fenrus.com> <B58A76BA-AE60-11D8-BD27-000A95CC3A8A@mesatop.com> <40B36E0B.3090605@kssb.net>
In-Reply-To: <40B36E0B.3090605@kssb.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bradley Hook wrote:

> Steven Cole wrote:
>
>>
>> On May 25, 2004, at 1:06 AM, Arjan van de Ven wrote:
>>
>>>> explanation part of the patch. That sign-off would be just a single 
>>>> line
>>>> at the end (possibly after _other_ peoples sign-offs), saying:
>>>>
>>>>     Signed-off-by: Random J Developer <random@developer.org>
>>>
>>>
>>>
>>> well this obviously needs to include that you signed off on the DCO and
>>> not some other random piece of paper, and it probably should include 
>>> the
>>> DCO revision number you signed off on.
>>> Without the former the Signed-off-by: line is entirely empty afaics,
>>> without the later we're not future proof.
>>>
>>>
>>
>> How about something like:
>>
>>     DCO 1.0 Signed-off-by: Random J Developer <random@developer.org>
>>
>> This new process being "an ounce of prevention is worth a pound
>> of cure" should retain the property of being lightweight and not
>> unduly burdensome.  This change seems to fall into that category.
>>
>>     Steven  -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
> Why not design the DCO so that it assumes an author accepts the most 
> recent published version unless specified. You could then shorten the 
> line to:
>
> DCO-Sign-Off: Random J Developer <random@developer.org>

If I'm looking at a 15 year old document where do I go to find out what
"most recent published version" meant at that time?  This assumes we're
talking about a document that has a clear timestamp.  If we care about
the version number at all, it should be in every signoff line.

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

