Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbSISOnS>; Thu, 19 Sep 2002 10:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269702AbSISOnS>; Thu, 19 Sep 2002 10:43:18 -0400
Received: from franka.aracnet.com ([216.99.193.44]:25773 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269645AbSISOnS>; Thu, 19 Sep 2002 10:43:18 -0400
Date: Thu, 19 Sep 2002 07:46:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@digeo.com>
Subject: Re: [chatroom benchmark version 1.0.1] Results
Message-ID: <418645270.1032421577@[10.10.2.3]>
In-Reply-To: <E17rwaz-0000vY-00@starship>
References: <E17rwaz-0000vY-00@starship>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And now the results:
>> 2.4.19-ck7.results:Average throughput : 55928 messages per second
>> 2.4.19.results:Average throughput : 44851 messages per second
>> 2.5.33.results:Average throughput : 59522 messages per second
>> 2.5.34.results:Average throughput : 62941 messages per second
>> 2.5.36.results:Average throughput : 60858 messages per second
>> 
>> 2.4.19-ck7 is preemption ON
>> 2.5.33 and 2.5.34 are preemption ON
>> 2.5.36 is preemption OFF (Robert, 2.5.36 with preemption ON oops at boot)
>
> There's also some kind of hint that preemption improves throughput
> here.

Any chance of doing two runs on exactly the same kernel, one with 
preempt on, and the other with preempt off? That's a much nicer 
hint ;-)

M.

