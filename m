Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSILUSd>; Thu, 12 Sep 2002 16:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSILUSd>; Thu, 12 Sep 2002 16:18:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:339 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317194AbSILUSc>; Thu, 12 Sep 2002 16:18:32 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209122022.g8CKMJS15137@devserv.devel.redhat.com>
Subject: Re: [PATCH] 2.4-ac task->cpu abstraction and optimization
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Thu, 12 Sep 2002 16:22:19 -0400 (EDT)
Cc: rml@tech9.net (Robert Love), alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <15744.57073.2852.707839@kim.it.uu.se> from "Mikael Pettersson" at Sep 12, 2002 08:37:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > also took a look at your patch -- looks good, you should submit it to
>  > Marcelo... it cannot hurt for 2.4.
> 
> I might do that, unless Alan plans on pushing the -ac sched.c stuff to
> Marcelo, in which case my patch would just confuse things. Alan?

I'd like to see it in 2.4 base. Its really Marcelo's call.
