Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263122AbTCSUTE>; Wed, 19 Mar 2003 15:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbTCSUTE>; Wed, 19 Mar 2003 15:19:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26606 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263122AbTCSUTD>;
	Wed, 19 Mar 2003 15:19:03 -0500
Message-ID: <3E78D32E.30800@mvista.com>
Date: Wed, 19 Mar 2003 12:29:34 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303190832430.32325-100000@gans.physik3.uni-rostock.de>	<3E78384A.6040406@mvista.com>	<20030319014230.3412298e.akpm@digeo.com>	<3E78B226.6050908@mvista.com> <20030319105135.1fe21020.akpm@digeo.com>
In-Reply-To: <20030319105135.1fe21020.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>george anzinger <george@mvista.com> wrote:
>>>
>>>
>>>>The attached patch is for 2.5.65.  As of this moment, the bk patch has 
>>>>not been posted to the snapshots directory.  I will wait for that to 
>>>>update.
>>>
>>>
>>>Don't use the snapshots directory.  Use
>>>
>>>	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/
>>
>>but then I need to pull each patch ... :)
>>
> 
> 
> No.  The link at the top:
> 
> 	"Gzipped full patch from v2.5.65 to ChangeSet 1.1171" 
> 
> is the diff from 2.5.65 to tip-of-tree.

Cool :)  Wish it were ...patch.gz instead of txt.gz, but then I would 
probably complain if I was hung with a new rope :)
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

