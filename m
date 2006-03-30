Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWC3Ubz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWC3Ubz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC3Ubz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:31:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:16290 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750829AbWC3Uby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:31:54 -0500
Message-ID: <442C4034.1060203@garzik.org>
Date: Thu, 30 Mar 2006 15:31:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Mattia Dongili <malattia@linux.it>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
References: <88056F38E9E48644A0F562A38C64FB6007A24C46@scsmsx403.amr.corp.intel.com> <442219A4.3080801@garzik.org> <442AE55B.5020007@tmr.com>
In-Reply-To: <442AE55B.5020007@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Jeff Garzik wrote:
>> Pallipadi, Venkatesh wrote:
>>>> From cpufreq perspective multiple things are possible in the way
>>> processor will support the multi-core frequency changing. and most of
>>> the things are handled at cpufreq inside kernel. I think there should be
>>> minima changes required in cpufreqd if any.
>>> Options:
>>
>>
>> 4) we power down a core.
>>
> Is this just for completeness of the set, something someone might do 
> someday, or does someone really have a hotplug core product?

Not hotplug, just power it down.

	Jeff



