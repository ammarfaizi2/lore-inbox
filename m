Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283002AbRLDJYy>; Tue, 4 Dec 2001 04:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282961AbRLDJXi>; Tue, 4 Dec 2001 04:23:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:1762 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282960AbRLDJXd>;
	Tue, 4 Dec 2001 04:23:33 -0500
Message-ID: <3C0C9590.6060301@stesmi.com>
Date: Tue, 04 Dec 2001 10:21:20 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011202122940.B2622@work.bitmover.com> <200112022252.XAA19497@webserver.ithnet.com> <20011202155440.F2622@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>>Please Larry, have a look at the environment: nobody here owns a box  
>>with 128 CPUs. Most of the people here take care of things they either
>>- own themselves                                                      
>>- have their hands own at work                                        
>>- get paid for                                                        
>>                                                                      
>>You will not find _any_ match with 128 CPUs here.                     
>>
> 
> Nor will you find any match with 4 or 8 CPU systems, except in very rare
> cases.  Yet changes go into the system for 8 way and 16 way performance.
> That's a mistake.
> 
> I'd be ecstatic if the hackers limited themselves to what was commonly 
> available, that is essentially what I'm arguing for.  

"There are only black cars, we don't make any other color. Noone has 
ordered a car with a different color cause we don't accept those orders. 
And since noone orders why add colors? Unnecessary cruft."

In essence, People don't run big boxes due to scalability issues, fixing 
those might get someone to install a 16-Way.

They sure as hell aren't gonna buy one and then wait around 3 years for 
Linux to support it.

// Stefan


