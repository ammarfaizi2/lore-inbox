Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbUDOFvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 01:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUDOFvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 01:51:47 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:15968 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263817AbUDOFvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 01:51:45 -0400
Message-ID: <407E22ED.6050802@yahoo.com.au>
Date: Thu, 15 Apr 2004 15:51:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: dvhltc@us.ibm.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
       mjbligh@us.ibm.com, ricklind@us.ibm.com, akpm@osdl.org
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch
References: <1081466480.10774.0.camel@farah>	<20040414154456.78893f3f.ak@suse.de>	<407D473B.8010109@yahoo.com.au> <20040414164135.75f1856f.ak@suse.de>
In-Reply-To: <20040414164135.75f1856f.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, 15 Apr 2004 00:14:19 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Where is STREAM versus other kernels? You said you got
>>best performance on a custom 2.4 kernel. Do we match
>>that?
> 
> 
> Differences were below the measurement error, so I consider it fixed.
> 

great.

> 
>>How is your performance for other things? I recall you
>>may have told me about some other (smaller) issues you
>>were seeing?
> 
> 
> I haven't tested much yet.  I can compare kernel compilations later.
> 

That would be good. I don't expect you to do all the work,
but Opteron being a non traditional NUMA, and me doing most
of my testing on an old NUMAQ makes them quite important.

Even if you just got some results for a couple of random
benchmarks would be great.

> Also I'm still somewhat hoping that the IBM benchmark team will take a stab at 
> it - they are much better than me at running many tests.
> 

Well we've survived OSDL's STP tests as far as I know. A
couple of regressions were found and fixed there, so that
was good.
