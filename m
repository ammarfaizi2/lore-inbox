Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVBOMZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVBOMZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVBOMZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:25:50 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:37893 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S261701AbVBOMZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:25:18 -0500
Message-ID: <4211E9A4.6010908@globaledgesoft.com>
Date: Tue, 15 Feb 2005 17:53:00 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is the purpose of GPIO pins.
References: <4211E434.7060405@globaledgesoft.com> <Pine.LNX.4.61.0502150713390.9458@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502150713390.9458@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    NO,  Sorry I wasn't clear.
    I am asking about GPIO controllers used in HandHeld Devices.
  
Regards,
Krishna Chaitanya

linux-os wrote:

> On Tue, 15 Feb 2005, krishna wrote:
>
>> Hi all,
>>
>>   Can any one tell me the purpose GPIO pin serves.
>>   How are GPIO pins better than dedicated pins, considering hardware 
>> design view and for programming view.
>>
>
> Do you mean General Purpose I/O bits on a chip?
>             ^       ^       ^ ^
> If so, it is intended to live in the lower 16 megabytes of
> an ix86 machine (higher addresses are not decoded), and at one
> time, went to the ISA bus, but is now usually a simple
> asynchronous bus off from some bridge.
>
>> From a hardware perspective, it's slow. From a programming
>
> perspective, you don't care where it is.
>
>> Regards,
>> Krishna Chaitanya
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
>
>
