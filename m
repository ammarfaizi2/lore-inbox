Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUC3ABx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUC3ABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:01:53 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:13441 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263213AbUC3ABu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:01:50 -0500
Message-ID: <4068B8E8.2030407@yahoo.com.au>
Date: Tue, 30 Mar 2004 10:01:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       jun.nakajima@intel.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
References: <200403291730.i2THUBo27915@owlet.beaverton.ibm.com>
In-Reply-To: <200403291730.i2THUBo27915@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
>     Rick Lindsley wrote:
>     > I've got a web page up now on my home machine which shows data from
>     > schedstats across the various flavors of 2.6.4 and 2.6.5-rc2 under
>     > load from kernbench, SPECjbb, and SPECdet.
>     > 
>     >     http://eaglet.rain.com/rick/linux/sched-domain/index.html
>     > 
>     
>     I can't see it
> 
> Ack, sorry, wrong path.  Hazards of typing at 3am .. should've used cut 'n'
> paste ...
> 
>     http://eaglet.rain.com/rick/linux/results/sched-domain/index.html
> 

Hi Rick,
This looks very cool. Very comprehensive. Have you got any
plans to intergrate it with sched_domains (so for example,
you can see stats for each domain)?

I will have to have a look at the code, it should be useful
for testing.

Thanks
Nick
