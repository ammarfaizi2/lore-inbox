Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTHWItX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 04:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTHWItX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 04:49:23 -0400
Received: from dyn-ctb-210-9-245-87.webone.com.au ([210.9.245.87]:48398 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262210AbTHWItW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 04:49:22 -0400
Message-ID: <3F472A40.2010905@cyberone.com.au>
Date: Sat, 23 Aug 2003 18:48:00 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: habanero@us.ibm.com, Bill Davidsen <davidsen@tmr.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org, mingo@elte.hu
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
References: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com> <200308221046.31662.habanero@us.ibm.com> <3F469FA4.6020203@cyberone.com.au> <200308221912.38184.habanero@us.ibm.com> <3F46B561.7060706@cyberone.com.au> <20030823004743.GB3170@holomorphy.com>
In-Reply-To: <20030823004743.GB3170@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Sat, Aug 23, 2003 at 10:29:21AM +1000, Nick Piggin wrote:
>
>>Hmm... get someone to try the scheduler benchmarks on a 32 way box ;)
>>
>
>What scheduler benchmark?
>
>

I don't know! I don't care about high end scheduler performance.
Volanomark? Kernbench? SDET? Whatever you care about.


