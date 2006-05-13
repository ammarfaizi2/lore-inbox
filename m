Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWEMENo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWEMENo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEMENo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:13:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26338 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932323AbWEMENn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:13:43 -0400
Message-ID: <44655CF3.5010101@garzik.org>
Date: Sat, 13 May 2006 00:13:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Stefan Smietanowski <stesmi@stesmi.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com> <446505F8.7020909@gmail.com>
In-Reply-To: <446505F8.7020909@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Stefan Smietanowski wrote:
>> Randy.Dunlap wrote:
>>>> * New error handling
>>>> * IRQ driven PIO (from Albert Lee)
>>>> * SATA NCQ support
>>>> * Hotplug support
>>>> * Port Multiplier support
>>>
>>> BTW, we often use PM to mean Power Management.
>>> Could we find a different acronym for Port Multiplier support,
>>> such as PMS or PX or PXS?
>>
>> Ok, maybe not PMS ?
>>
>> Can you imagine a bug report from someone that "has problem with PMS"?
>> :)
>>
> 
> Would be fun though.  :)
> 
> I thought about using another acronym for port multiplier too.  But the 
> spec uses that acronym all over the place, PM, PMP (Port Multiplier 
> Portnumber), which reminds me of USB full/high speed fiasco.
> 
> Urghh... I thought we could use power for power management inside libata 
> but that might be a bad idea.  So, PMS?

PMS is fine.  I encouraged the use of "UFO" for "UDP Fragmentation 
Offload" in network driver land, and it stuck.

This is Linux, we like to have fun around here :)

	Jeff



