Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUHEDgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUHEDgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 23:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHEDgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 23:36:47 -0400
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:11753 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S265654AbUHEDgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 23:36:46 -0400
Message-ID: <4111AB49.5010003@bigpond.net.au>
Date: Thu, 05 Aug 2004 13:36:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube> <41118AAE.7090107@bigpond.net.au> <41118D0C.9090103@yahoo.com.au> <411196EE.9050408@bigpond.net.au> <41119A3B.2020202@yahoo.com.au> <4111A39C.40200@bigpond.net.au> <4111A418.5030101@yahoo.com.au>
In-Reply-To: <4111A418.5030101@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Peter Williams wrote:
> 
>> Nick Piggin wrote:
>>
>>> However if you add or remove scheduling policies, your
>>> p->policy method breaks.
>>
>>
>>
>> Not if Albert's numbering system is used.
>>
> 
> What if another realtime policy is added? Or one is removed?

What if the "prio" field is removed?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

