Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWFAKLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWFAKLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWFAKLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:11:17 -0400
Received: from tornado.reub.net ([202.89.145.182]:22958 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964927AbWFAKLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:11:16 -0400
Message-ID: <447EBD46.7010607@reub.net>
Date: Thu, 01 Jun 2006 22:11:18 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060531)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org>	<447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org>
In-Reply-To: <20060601025632.6683041e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/06/2006 9:56 p.m., Andrew Morton wrote:
> On Thu, 01 Jun 2006 21:34:37 +1200
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>>
>> On 1/06/2006 8:48 p.m., Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
>>>
>>>
>>> - A cfq bug was fixed in mainline, so the git-cfq tree has been restored.
>>>
>>> - Various lock-validator and genirq fixes have been added.  Should be
>>>   slightly less oopsy than 2.6.17-rc5-mm1.
>>>
>>> - I just realised that I've been accidentally not updating the PCI tree for
>>>   a while.  Will be restored in next -mm.
>>>
>>> - Has been booted and has passed various stress-tests on quad x86_64,
>>>   quad ancient-Xeon, quad power4, quad ia64, dual old-PIII and a modern
>>>   pentium-M laptop.  So if it breaks, it's your fault.
>> What an optimist if ever I've seen one ;)
> 
> Dammit.

> A .config would be useful too.

Now up at http://www.reub.net/files/kernel/configs/2.6.17-rc5-mm2-x86_64.confg

(and yes, using AHCI)

Reuben
