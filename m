Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282923AbRLCIvy>; Mon, 3 Dec 2001 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282988AbRLCItC>; Mon, 3 Dec 2001 03:49:02 -0500
Received: from bitmover.com ([192.132.92.2]:36557 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284442AbRLBXyl>;
	Sun, 2 Dec 2001 18:54:41 -0500
Date: Sun, 2 Dec 2001 15:54:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Larry McVoy <lm@bitmover.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011202155440.F2622@work.bitmover.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Larry McVoy <lm@bitmover.com>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011202122940.B2622@work.bitmover.com> <200112022252.XAA19497@webserver.ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200112022252.XAA19497@webserver.ithnet.com>; from skraw@ithnet.com on Sun, Dec 02, 2001 at 11:52:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please Larry, have a look at the environment: nobody here owns a box  
> with 128 CPUs. Most of the people here take care of things they either
> - own themselves                                                      
> - have their hands own at work                                        
> - get paid for                                                        
>                                                                       
> You will not find _any_ match with 128 CPUs here.                     

Nor will you find any match with 4 or 8 CPU systems, except in very rare
cases.  Yet changes go into the system for 8 way and 16 way performance.
That's a mistake.

I'd be ecstatic if the hackers limited themselves to what was commonly 
available, that is essentially what I'm arguing for.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
