Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWDES12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWDES12 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWDES12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:27:28 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:3767 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751321AbWDES11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:27:27 -0400
Message-ID: <4432C973.9080509@tmr.com>
Date: Tue, 04 Apr 2006 15:30:59 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060330 SeaMonkey/1.5a
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Mattia Dongili <malattia@linux.it>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
References: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com> <442219A4.3080801@garzik.org> <442AE55B.5020007@tmr.com> <442C4034.1060203@garzik.org>
In-Reply-To: <442C4034.1060203@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Bill Davidsen wrote:
>> Jeff Garzik wrote:
>>> Pallipadi, Venkatesh wrote:
>>>>> From cpufreq perspective multiple things are possible in the way
>>>> processor will support the multi-core frequency changing. and most of
>>>> the things are handled at cpufreq inside kernel. I think there 
>>>> should be
>>>> minima changes required in cpufreqd if any.
>>>> Options:
>>>
>>>
>>> 4) we power down a core.
>>>
>> Is this just for completeness of the set, something someone might do 
>> someday, or does someone really have a hotplug core product?
> 
> Not hotplug, just power it down.
> 
Is that actually possible on any current hardware? I didn't see it in 
any doc I have, but it's all "CPU specs for dummies." ;-)

