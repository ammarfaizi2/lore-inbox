Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290486AbSAYBhj>; Thu, 24 Jan 2002 20:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290488AbSAYBha>; Thu, 24 Jan 2002 20:37:30 -0500
Received: from freeside.toyota.com ([63.87.74.7]:46853 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S290486AbSAYBhK>; Thu, 24 Jan 2002 20:37:10 -0500
Message-ID: <3C50B6BD.8080307@lexus.com>
Date: Thu, 24 Jan 2002 17:37:01 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing the effects of the low latency patch
In-Reply-To: <3C50AC22.7090203@lexus.com> <3C50AEE1.2300BB05@zip.com.au> <3C50B185.40006@lexus.com> <3C50B37C.9EACC94B@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was during gameplay, no dbench running, which
as it turns out is a workload of interest for me -

Joe

Andrew Morton wrote:

>J Sloan wrote:
>
>>>>2.4.18-pre6+tux+nfs-fixes
>>>>-------------
>>>>...
>>>>7.6 1
>>>>7.8 1
>>>>21.1 1
>>>>
>>>This is the stock kernel.  In twenty minutes you suffered
>>>precisely *one* scheduling overrun which is perceptible
>>>by a human.  The rest are much shorter than your monitor's
>>>refresh interval.  Interesting, yes?
>>>
>>Yes, the stock kernel is much improved from
>>say 6 months ago. I will take a look at the
>>kernel that shipped with my distro just for
>>giggles as well...
>>
>
>Was you histogram generated during a game session, or during
>dbench?  write()-intensive workloads are the main common
>offender.
>
>-
>


