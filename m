Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272548AbTHJIOj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272568AbTHJIOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:14:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:64729 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272548AbTHJIOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:14:36 -0400
Message-Id: <5.2.1.1.2.20030810101700.019bc528@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 10:18:43 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  
  ...
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F35FAC0.7020000@cyberone.com.au>
References: <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net>
 <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
 <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
 <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:56 PM 8/10/2003 +1000, Nick Piggin wrote:


>Mike Galbraith wrote:
>
>>At 03:43 PM 8/10/2003 +1000, Nick Piggin wrote:
>>
>>
>>>Roger Larsson wrote:
>>>
>>>>*       SCHED_FIFO requests from non root should also be treated as 
>>>>SCHED_SOFTRR
>>>
>>>I hope computers don't one day become so fast that SCHED_SOFTRR is
>>>required for skipless mp3 decoding, but if they do, then I think
>>>SCHED_SOFTRR should drop its weird polymorphing semantics ;)
>>
>>
>>:)  My box is slow enough to handle them just fine, as long as I make 
>>sure that oinkers don't share the same queue with the light weight player.
>
>
>Just my (unsuccessful) attempt at humor!

(was successful here... made for wide grin:)


