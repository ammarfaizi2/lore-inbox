Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSJRVka>; Fri, 18 Oct 2002 17:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSJRVka>; Fri, 18 Oct 2002 17:40:30 -0400
Received: from dsl-213-023-020-002.arcor-ip.net ([213.23.20.2]:28850 "EHLO
	starship") by vger.kernel.org with ESMTP id <S265333AbSJRVk0>;
	Fri, 18 Oct 2002 17:40:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@muc.de>
Subject: Re: 2.5 and lowmemory boxens
Date: Fri, 18 Oct 2002 23:46:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
References: <E182V29-000Pfa-00@f15.mail.ru> <m37kggyo7r.fsf@averell.firstfloor.org> <3DB03BC9.F2986C53@digeo.com>
In-Reply-To: <3DB03BC9.F2986C53@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E182ex9-0004yc-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 18:50, Andrew Morton wrote:
> > "Samium Gromoff" <_deepfire@mail.ru> writes:
> > >    first: i`ve successfully ran 2.5.43 on a 386sx20/4M ram notebook.
>
> ...
>
> timer.c and sched.c have significant NR_CPUS bloat problems on SMP.
> Working on that.

Oooh, yes!  So 2.6 will be just fine for my smp dsl router...

Seriously, we are getting closer to the day notebooks start shipping with
multi-core processors, and it's not beyond belief that a dsl router would
benefit from this as well.  I.e., super-high processing power, but hardly
any memory/flash required.  Xmeta, listening?  What better geek trophy than
a 4-way notebook.

-- 
Daniel
