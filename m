Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318794AbSHRAvT>; Sat, 17 Aug 2002 20:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHRAvS>; Sat, 17 Aug 2002 20:51:18 -0400
Received: from bitmover.com ([192.132.92.2]:58018 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318794AbSHRAvS>;
	Sat, 17 Aug 2002 20:51:18 -0400
Date: Sat, 17 Aug 2002 17:55:17 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Dax Kelson <dax@gurulabs.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Does Solaris really scale this well?
Message-ID: <20020817175517.A31128@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Dax Kelson <dax@gurulabs.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20020817182715.GC32427@mea-ext.zmailer.org> <Pine.LNX.4.44.0208172358460.3111-100000@sharra.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208172358460.3111-100000@sharra.ivimey.org>; from Ruth.Ivimey-Cook@ivimey.org on Sun, Aug 18, 2002 at 12:03:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 12:03:24AM +0100, Ruth Ivimey-Cook wrote:
> >> "When you take a 99-way UltraSPARC III machine and add a 100th processor, 
> >> you get 94 percent linear scalability. You can't get 94 percent linear 
> >> scalability on your first Intel chip. It's very, very hard to do, and they 
> >> have not done it."
> 
> I've seen scientific reports of scalability that good in non-shared memory
> computers (mostly in transputer arrays) where (with a scalable algorithm)
> unless you got >90% you were doing something wrong.  However, if you insist on
> sharing main memory, I still don't believe you can get anywhere near that...
> IMO 30% is doing very well once past the first few CPUs.

Please reconsider your opinion.  Both Sun and SGI scale past 100 CPUs on
reasonable workloads in shared memory.  Where "reasonable" != easy to do.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
