Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUHZCmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUHZCmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 22:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUHZCmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 22:42:15 -0400
Received: from gizmo12bw.bigpond.com ([144.140.70.43]:41132 "HELO
	gizmo12bw.bigpond.com") by vger.kernel.org with SMTP
	id S266748AbUHZCmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 22:42:13 -0400
Message-ID: <412D4E01.7000504@bigpond.net.au>
Date: Thu, 26 Aug 2004 12:42:09 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040826023028.39690.qmail@web13926.mail.yahoo.com>
In-Reply-To: <20040826023028.39690.qmail@web13926.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com wrote:
> --- Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>You could try Lee Revell's (rlrevell@joe-job.com) latency measuring 
>>patches and also try applying Ingo Molnar's (mingo@elte.hu) 
>>voluntary-preempt patches.
>>
>>Peter
> 
> 
> I tried 2.6.8.1 with voluntary-preempt-2.6.8.1-P9 and I am getting latency
> messages, they trigger at around the same time I get "delta = 3" messages.
> 
> I guess that there is no way to have the latency reporting work with the zaphod
> patch?

I'll see what I can do and let you know.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

