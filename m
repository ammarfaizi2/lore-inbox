Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUHYDs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUHYDs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUHYDs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:48:28 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20327 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268458AbUHYDsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:48:22 -0400
Date: Tue, 24 Aug 2004 21:40:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: HDD LED doesn't light.
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <00b801c48a55$46a2e3b0$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=response
Content-transfer-encoding: 8BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.j6vg864.plk4g8@ifi.uio.no> <fa.e807bv7.klg10f@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to remember hearing somewhere that some or all of the Silicon Image 
SATA chips have to control the HDD activity light output by twiddling some 
GPIO outputs in the driver, it's not inherently done in the hardware as with 
most controllers..


----- Original Message ----- 
From: "Fernando O. Korndörfer" <fok@quatro.com.br>
Newsgroups: fa.linux.kernel
To: "Ben Skeggs" <d4rk74m4@intas.net.au>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, August 24, 2004 7:10 AM
Subject: Re: HDD LED doesn't light.


> This seems to be a hardware problem, as I have similar hardware (Asus 
> A7N8x-e deluxe) and the HDD Led also stays off.
> BTW, I'm using MS-Windows(R).
>
> Tell me something, you'r using SATA, right?
>
>
> Ben Skeggs wrote:
>
>>Hello,
>>
>>No matter how much harddisk activity is occuring on my system, the 
>>harddisk LED stays off.  At first I thought I'd misconnected the lead, but 
>>under Windows the light is functional.
>>
>>This occurs on both my SATA harddisk and my PATA harddisk.
>>
>>SATA controller: Silicon Image sil3112
>>PATA controller: NForce2
>>Motherboard    : Abit NF7-S 2.0
>>CPU            : AthlonXP 3000+
>>
>>The earliest kernel I've used with this hardware is 2.6.6, and the problem 
>>occurs right up to 2.6.8.1.
>>
>>I'm completely clueless as I was under the impression that the hardware 
>>controlled the LED.
>>
>>Could I please be CC'd any replies as I'm not subscribed to the list.
>>
>>Regards,
>>Ben Skeggs
>>-

