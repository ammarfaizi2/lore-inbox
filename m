Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284361AbRLCIvr>; Mon, 3 Dec 2001 03:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284381AbRLCItw>; Mon, 3 Dec 2001 03:49:52 -0500
Received: from ns.ithnet.com ([217.64.64.10]:7176 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284354AbRLBWwr>;
	Sun, 2 Dec 2001 17:52:47 -0500
Message-Id: <200112022252.XAA19497@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Date: Sun, 02 Dec 2001 23:52:32 +0100
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: Larry McVoy <lm@bitmover.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
In-Reply-To: <20011202122940.B2622@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Dec 01, 2001 at 08:05:59PM -0300, Horst von Brand wrote:    
> > Just as Linus said, the development is shaped by its environment. 
>                                                                     
> Really?  So then people should be designing for 128 CPU machines,   
right?                                                                
> So why is it that 100% of the SMP patches are incremental?  Linux is
                                                                      
> following exactly the same path taken by every other OS, 1->2, then 
2->4,                                                                 
> then 4->8, etc.  By your logic, someone should be sitting down and  
saying                                                                
> here is how you get to 128.  Other than myself, noone is doing that 
and                                                                   
> I'm not really a Linux kernel hack, so I don't count.               
>                                                                     
> So why is it that the development is just doing what has been done  
before?                                                               
                                                                      
Please Larry, have a look at the environment: nobody here owns a box  
with 128 CPUs. Most of the people here take care of things they either
- own themselves                                                      
- have their hands own at work                                        
- get paid for                                                        
                                                                      
You will not find _any_ match with 128 CPUs here.                     
                                                                      
_Obviously_ you are completely right if this were a company _building_
these boxes. Then your question is the right one, as they would get   
paid for the job.                                                     
But this is a different environment. As long as you cannot buy these  
boxes at some local store for a buck and a bit, you will have no      
chance to find willing people for your approach. Therefore it is      
absolutely clear, that it will (again) walk the line from 1,2,4,8 ... 
CPUs, because the boxes will be available along this line.            
                                                                      
I give you this advice: if you _really_ want to move something in this
area, find someone who should care about this specific topic, and has 
the money _and_ the will to pay for development of critical GPL code  
like this.                                                            
Take the _first_ step: create the environment. _Then_ people will come
and follow your direction.                                            
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
