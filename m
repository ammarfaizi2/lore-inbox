Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317594AbSFNLNk>; Fri, 14 Jun 2002 07:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSFNLNj>; Fri, 14 Jun 2002 07:13:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15590 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317594AbSFNLNi>;
	Fri, 14 Jun 2002 07:13:38 -0400
Date: Fri, 14 Jun 2002 13:11:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] 2.5.21 deadlocks on UP (SMP kernel) w/ IOAPIC
In-Reply-To: <Pine.LNX.4.44.0206141106330.30400-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0206141310500.6969-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Jun 2002, Zwane Mwaikambo wrote:

> Hi Ingo,
> 	The balance_irq/move code in 2.5.21 currently deadlocks on my UP 
> box due to the following;

> Please apply

looks good to me.

	Ingo

