Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282691AbRLDCBe>; Mon, 3 Dec 2001 21:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRLDCAE>; Mon, 3 Dec 2001 21:00:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34693 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282169AbRLDB7a>; Mon, 3 Dec 2001 20:59:30 -0500
Date: Mon, 03 Dec 2001 17:59:04 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>, Stephan von Krawczynski <skraw@ithnet.com>
cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <2379997133.1007402344@mbligh.des.sequent.com>
In-Reply-To: <20011202155440.F2622@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please Larry, have a look at the environment: nobody here owns a box  
>> with 128 CPUs. Most of the people here take care of things they either
>> - own themselves                                                      
>> - have their hands own at work                                        
>> - get paid for                                                        
>>                                                                       
>> You will not find _any_ match with 128 CPUs here.                     
> 
> Nor will you find any match with 4 or 8 CPU systems, except in very rare
> cases.  Yet changes go into the system for 8 way and 16 way performance.
> That's a mistake.
> 
> I'd be ecstatic if the hackers limited themselves to what was commonly 
> available, that is essentially what I'm arguing for.  

We need a *little* bit of foresight. If 4 ways are common now, and 8 ways 
and 16 ways are available, then in a year or two 8 ways (at least) will be
commonplace. On the other hand 128 cpu machines are a way off, and 
I'd agree we shouldn't spend too much time on them right now.

Martin.

