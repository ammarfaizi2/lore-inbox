Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbUJ1MMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbUJ1MMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbUJ1MMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:12:37 -0400
Received: from opersys.com ([64.40.108.71]:62724 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262982AbUJ1MIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:08:15 -0400
Message-ID: <4180DF18.5060808@opersys.com>
Date: Thu, 28 Oct 2004 07:59:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Restricted hard realtime
References: <20041023194721.GB1268@us.ibm.com> <417F12F1.5010804@opersys.com> <20041026212956.4729ce98.akpm@osdl.org> <20041027081044.GA14451@elte.hu>
In-Reply-To: <20041027081044.GA14451@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> with -RT-V0.3 i get lower than 20 usec _maximum_ latencies during
> './hackbench 20'. (the average latency is 1 usec) So while i'm not yet
> in the sub-femtosecond category, things are looking pretty good in
> PREEMPT_REALTIME land :)

Just curious: what's the setup here? (CPU speed, peripherals, distro,
applications being run to load the system, etc.) You may have described
this elsewhere on LKML and I may have missed it (sorry, I just can't
read everything that comes through).

I'm assuming that the timings are measured using the tracing
functionality currently in the patches.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

