Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUHKRTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUHKRTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUHKRTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:19:31 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:62779 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S268127AbUHKRT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:19:26 -0400
Message-ID: <411A5520.9000805@nec-labs.com>
Date: Wed, 11 Aug 2004 10:19:28 -0700
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Barbato <lu_zero@gentoo.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compression algorithm in cloop
References: <411A348D.9070808@nec-labs.com> <411A50CD.3070908@gentoo.org>
In-Reply-To: <411A50CD.3070908@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2004 17:19:25.0736 (UTC) FILETIME=[59F05A80:01C47FC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great! That certainly should help!

The problem is, how can I put the algorithm in the kernel? Is there a 
forum or mailing list for this kind of work?

Thanks!
Lei

Luca Barbato wrote:
> Lei Yang wrote:
> 
>> Hello,
>>
>> I am trying to do some experiment on compression ratios with cloop. I 
>> know that currently cloop uses zlib. How can I change it to other 
>> algorithms? Where should I start from? Really a newbie to this, 
>> appreciate any comments!!
>>
>> TIA.
>> Lei
>>
> I made a variation from cloop called gcloop it could use any algorithm 
> you can put in the kernel (I use an hack to use ucl right now)
> 
> You can find it at dev.gentoo.org/~lu_zero/gcloop
> 
> I hope it helps.
> 
> lu
> 
