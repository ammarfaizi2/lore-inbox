Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWCBKzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWCBKzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbWCBKzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:55:55 -0500
Received: from coumail01.netbenefit.co.uk ([212.53.64.106]:22668 "EHLO
	coumail01.netbenefit.co.uk") by vger.kernel.org with ESMTP
	id S1751449AbWCBKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:55:54 -0500
Message-ID: <010001c63de7$dc132620$0a00a8c0@emachine>
From: "Michael Gilroy" <mgilroy@a2etech.com>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <002a01c63228$abda02f0$0a00a8c0@emachine> <728201270602150913j4e8292fdh8e53cfe988a27dd3@mail.gmail.com> <001001c632e7$23d89af0$0a00a8c0@emachine> <728201270602161330s4d99369eye2d28cfa46f12899@mail.gmail.com>
Subject: Re: Kernel bug mm/page_alloc.c
Date: Thu, 2 Mar 2006 10:55:46 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     apologies for the delay in replying I've been out of the country.
I'm using the 2.6.15.2 kernel. I know that the bug is only appearing when
I'm using the raid6 driver in combination with my hardware. I've yet to
narrow it down any further though and would appreciate it if anyone could
give me a better idea as to how to narrow down the cause of the problem.

regards,

mike

----- Original Message ----- 
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Michael Gilroy" <mgilroy@a2etech.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, February 16, 2006 9:30 PM
Subject: Re: Kernel bug mm/page_alloc.c


On 2/16/06, Michael Gilroy <mgilroy@a2etech.com> wrote:
> I'm using an AMD opteron so I can't see how the F00F bug could be 
> affecting
> me. I don't have that option in my .config file either. Any other
> suggestions?
>
> thanks,
>
> mike

Does this problem pop up without the RAID6 driver also. That may be
helpful in isolating the bug.

regards
Ram Gupta
>
>


