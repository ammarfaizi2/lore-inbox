Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUDNO1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUDNO1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:27:36 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:49757 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263733AbUDNO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:27:35 -0400
Message-ID: <407D473B.8010109@yahoo.com.au>
Date: Thu, 15 Apr 2004 00:14:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, mjbligh@us.ibm.com, ricklind@us.ibm.com,
       akpm@osdl.org
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch
References: <1081466480.10774.0.camel@farah> <20040414154456.78893f3f.ak@suse.de>
In-Reply-To: <20040414154456.78893f3f.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, 08 Apr 2004 16:22:09 -0700
> Darren Hart <dvhltc@us.ibm.com> wrote:
> 
> 
> 
>>This patch is intended as a quick fix for the x86_64 problem, and
> 
> 
> Ingo's latest tweaks seemed to already cure STREAM, but some more
> tuning is probably a good idea agreed.
> 

Where is STREAM versus other kernels? You said you got
best performance on a custom 2.4 kernel. Do we match
that?

How is your performance for other things? I recall you
may have told me about some other (smaller) issues you
were seeing?
