Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVGGOE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVGGOE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVGGOBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:01:10 -0400
Received: from alog0361.analogic.com ([208.224.222.137]:16544 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261572AbVGGOAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:00:25 -0400
Date: Thu, 7 Jul 2005 09:59:03 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jens Axboe <axboe@suse.de>
cc: raja <vnagaraju@effigent.net>, linux-kernel@vger.kernel.org
Subject: Re: function Named
In-Reply-To: <20050707135621.GC24401@suse.de>
Message-ID: <Pine.LNX.4.61.0507070956510.10140@chaos.analogic.com>
References: <42CD25FA.6030100@effigent.net> <Pine.LNX.4.61.0507070939200.9975@chaos.analogic.com>
 <20050707135621.GC24401@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Jens Axboe wrote:

> On Thu, Jul 07 2005, Richard B. Johnson wrote:
>> On Thu, 7 Jul 2005, raja wrote:
>>
>>> hi,
>>>   Is there any way to get the function address by only knowing the
>>> function Name
>>> thanking you,
>>> -
>>
>> 	printf("%p\n", function());   // User code
>> 	printk("%p\n", function());   // Kernel code
>
> Yup that'll work fine, provided 'function' takes no arguments and
> returns its own address.

Sorry meant..........

 	printf("%p\n", function);   // User code
>

I wanted to show that 'function' was a `function()`.

> -- 
> Jens Axboe
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
