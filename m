Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUJORy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUJORy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUJORy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:54:58 -0400
Received: from mail3.utc.com ([192.249.46.192]:63963 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266879AbUJORy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:54:56 -0400
Message-ID: <41700EDF.7010904@cybsft.com>
Date: Fri, 15 Oct 2004 12:54:39 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
In-Reply-To: <20041015102633.GA20132@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -U3 PREEMPT_REALTIME patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> 

Overall, for me, this just seems to be getting better and better with 
each iteration. I have posted a few traces that I have captured during 
some of my testing on my SMP system at home. Only the last four are from 
U3 (9-12). The others are from previous versions and in some cases 
probably aren't relevant any more. No. 9 which is the worst I've seen 
with U3 very well may have happened before the system was up completely.

Traces:
http://www.cybsft.com/testresults/2.6.9-rc4-mm1-VP/

kr
