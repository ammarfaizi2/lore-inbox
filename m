Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWGDIGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWGDIGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWGDIGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:06:04 -0400
Received: from lucidpixels.com ([66.45.37.187]:33261 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751053AbWGDIGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:06:01 -0400
Date: Tue, 4 Jul 2006 04:06:00 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Jeff Garzik <jeff@garzik.org>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Linux SATA Support Question - Is the ULI M1575 chip supported?
In-Reply-To: <44A9BD0B.8010104@garzik.org>
Message-ID: <Pine.LNX.4.64.0607040405370.30019@p34.internal.lan>
References: <Pine.LNX.4.64.0607031756510.3342@p34.internal.lan>
 <44A9BD0B.8010104@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jul 2006, Jeff Garzik wrote:

> Justin Piszcz wrote:
>> 
>> In the source:
>> 
>> enum {
>>         uli_5289                = 0,
>>         uli_5287                = 1,
>>         uli_5281                = 2,
>>
>>         uli_max_ports           = 4,
>>
>>         /* PCI configuration registers */
>>         ULI5287_BASE            = 0x90, /* sata0 phy SCR registers */
>>         ULI5287_OFFS            = 0x10, /* offset from sata0->sata1 phy 
>> regs */
>>         ULI5281_BASE            = 0x60, /* sata0 phy SCR  registers */
>>         ULI5281_OFFS            = 0x60, /* offset from sata0->sata1 phy 
>> regs */
>> };
>> 
>> However, in the manual for this motherboard it states it has a ULI M1575, 
>> can anyone comment?
>> 
>> http://us.dfi.com.tw/Upload/Manual/90800601.pdf
>
> What is the PCI ID?
>
> 	Jeff
>
>
>

Don't have the board yet, researching different motherboards for Linux 
compatbility -before- purchase..

Justin.
