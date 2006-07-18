Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWGRP0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWGRP0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWGRP0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:26:36 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:36284 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932239AbWGRP0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:26:35 -0400
Message-ID: <44BCFDA6.3030909@cmu.edu>
Date: Tue, 18 Jul 2006 11:26:30 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060604)
MIME-Version: 1.0
To: Jeff Chua <jchua@fedex.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com>
In-Reply-To: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpid has been started, however there is no /sys/power/disk

Jeff Chua wrote:
> Do you see a file /sys/power/disk ?
> 
> Did you start "acpid"?
> 
> Also, can you "cat /sys/power/disk" ? May be your X60 does not support this.
> 
> Let me know.
> 
> Thanks,
> Jeff 
> [ jchua@fedex.com ]  
> 
>> -----Original Message-----
>> From: George Nychis [mailto:gnychis@cmu.edu] 
>> Sent: Tuesday, July 18, 2006 10:27 AM
>> To: Jeff Chua
>> Subject: Re: suspend/hibernate to work on thinkpad x60s?
>>
>> linux-2.6.18-rc1-git7
>>
>> Do i need special support for this somewhere in the kernel?
>>
>> Jeff Chua wrote:
>>>
>>> On Mon, 17 Jul 2006, George Nychis wrote:
>>>
>>>> Am i missing some kind of support?
>>>> x60s gnychis # echo platform > /sys/power/disk; echo disk > 
>>>> /sys/power/state
>>>> bash: /sys/power/disk: Permission denied
>>>> bash: echo: write error: Invalid argument
>>>
>>> I'm using linux-2.6.18-rc2. What version is yours?
>>>
>>>
>>> Jeff.
>>>
> 
