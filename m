Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUGIHHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUGIHHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 03:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUGIHHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 03:07:18 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:27791 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261405AbUGIHHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 03:07:17 -0400
Message-ID: <40EE4421.2000206@yahoo.com.au>
Date: Fri, 09 Jul 2004 17:07:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "David S. Miller" <davem@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com> <20040707073510.GA27609@elte.hu> <20040707140249.2bfe0a4b.davem@redhat.com> <40EE06B1.1090202@yahoo.com.au> <20040709025151.GV21066@holomorphy.com> <40EE288F.20301@yahoo.com.au> <20040709065830.GY21066@holomorphy.com>
In-Reply-To: <20040709065830.GY21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Please present a self-contained fixed-up init_idle() cleanup for me to
>>>testboot. Even the one in -mm is not so, as it depends on later patches
>>>to even compile.
> 
> 
> On Fri, Jul 09, 2004 at 03:09:35PM +1000, Nick Piggin wrote:
> 
>>The patch I just sent (which is on top of -mm6) should hopefully
>>work... if you feel like testing a solution that may still get
>>vetoed by Ingo.
>>Also, what compile errors are you getting? i386 seems to compile
>>kernel/ fine with only the first sched- patch applied.
> 
> 
> "atop -mm6" is not what I'd call a self-contained patch. I'm relatively
> irritated about the approach to (or perhaps even avoidance of) testing
> in isolation going on here. I have other things I very urgently need to

I'll take that as a no.

> do, and I doubt whatever I get for doing your homework for you will pay
> for screwing up public presentations. I have had enough trouble in
> general isolating causes of failures, so please prep this properly.
> 

I don't really follow you.

And you still haven't told me what compile errors you are getting.
I don't have an evironment to build or test a sparc64 kernel.
