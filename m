Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUJVRhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUJVRhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUJVRhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:37:48 -0400
Received: from mail3.utc.com ([192.249.46.192]:48092 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S267737AbUJVRgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:36:31 -0400
Message-ID: <41794508.5060000@cybsft.com>
Date: Fri, 22 Oct 2004 12:36:08 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Ingo Molnar <mingo@elte.hu>, "J.A. Magallon" <jamagallon@able.es>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es> <41661013.9090700@cybsft.com> <41668346.6090109@adaptec.com> <20041022135800.GA8254@elte.hu> <41791302.5030305@adaptec.com> <20041022140701.GC8120@elte.hu> <41791BE6.7040209@adaptec.com> <20041022145559.GA12434@elte.hu> <4179216A.8020302@adaptec.com>
In-Reply-To: <4179216A.8020302@adaptec.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> Ingo Molnar wrote:
> 
>> * Luben Tuikov <luben_tuikov@adaptec.com> wrote:
>>
>>
>>>> no, i havent. Is it easy to apply that tree to 2.6.9-rc4-mm1?
>>>
>>>
>>> Yes, I think so.  There's 2 patches there for the AIC drivers: the PCI
>>> tables and sleeping while holding a lock.
>>
>>
>>
>> linux-scsi.bkbits.net seems to be down - is there any alternate site 
>> for the patches?
> 
> 
> Yes.  Attached to this email.  (if I append them, a space gets
> added for some unknown reason)
> 
> Let me know how it works out.
> 
>     Luben

This works fine for me.

thanks,

kr
