Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSJQCt0>; Wed, 16 Oct 2002 22:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJQCtZ>; Wed, 16 Oct 2002 22:49:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:48533 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261638AbSJQCtZ>;
	Wed, 16 Oct 2002 22:49:25 -0400
Message-ID: <3DAE2691.76F83D1B@digeo.com>
Date: Wed, 16 Oct 2002 19:55:13 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Parker <steve.parker@netops.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 still not testable by end users
References: <Pine.GSO.4.44.0210170326540.25203-100000@www>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 02:55:14.0270 (UTC) FILETIME=[9DC487E0:01C27588]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Parker wrote:
> 
> I've been trying to test the 2.5 kernel since 2.5.39, but these warnings
> really scare me off... 
> ...
> Oct 16 21:40:59 declan kernel: Debug: sleeping function called from
> illegal context at mm/slab.c:1374

It's just debug.  Everyone gets it.  Don't worry about it.

It's there to remind the IDE developers to fix it.

> Oct 16 21:40:59 declan kernel: Call Trace:
> ...
> Oct 16 21:40:59 declan kernel:  [__might_sleep+84/96]
> ...
> Oct 16 21:41:00 declan kernel:  [init_irq+637/820] init_irq+0x27d/0x334
>

One day.  Before we all die.  Please.
