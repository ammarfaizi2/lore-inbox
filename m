Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTIXNNC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 09:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTIXNNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 09:13:01 -0400
Received: from dyn-ctb-203-221-73-21.webone.com.au ([203.221.73.21]:50191 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261342AbTIXNM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 09:12:58 -0400
Message-ID: <3F719855.5010703@cyberone.com.au>
Date: Wed, 24 Sep 2003 23:12:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] must fix list
References: <3F67EDAF.40608@cyberone.com.au> <20030916234746.0612ec90.akpm@osdl.org>
In-Reply-To: <20030916234746.0612ec90.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>> I don't know what happened to this, but I thought it was quite good.
>> Maybe I missed something?
>>
>
>It just didn't seem very relevant: people weren't keeping me up to date and
>a lot of the patches which were going in weren't related to anything on the
>lists.
>

I liked it. I think it gives you a good idea of the bigger changes
that need to happen and who is doing what. It might be a good idea to
keep around when you want to impose some sort of code freeze.

>
>> Anyway I have removed AS from the list because it is done. I removed CFQ
>> as well because when the schedulers become runtime selectable (sometime
>> I hope), merging it becomes a non issue, even during the stable series I
>> think.
>>
>> I updated the kernel/sched.c section a bit.
>>
>> I moved 64-bit dev_t from should fix to must fix.
>>
>> It looks like quite a bit can be struck off, but I'll leave it up to those
>> who actually did the work.
>>
>
>Thanks.  Just for you, I'll do an update.
>

Hows it going?

>
>> Maybe these should go in Documentation/must-fix/ to make patching and
>> syncing easier?
>>
>
>maybe...
>
>

IMO it would help

