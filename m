Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282976AbRL0XE0>; Thu, 27 Dec 2001 18:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282979AbRL0XEP>; Thu, 27 Dec 2001 18:04:15 -0500
Received: from ns.ithnet.com ([217.64.64.10]:64267 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282976AbRL0XEL>;
	Thu, 27 Dec 2001 18:04:11 -0500
Message-Id: <200112272304.AAA05151@webserver.ithnet.com>
Cc: "James Stevenson" <mistral@stev.org>, jlladono@pie.xtec.es,
        linux-kernel@vger.kernel.org
Date: Fri, 28 Dec 2001 00:04:01 +0100
Subject: Re: 2.4.x kernels, big ide disks and old bios
To: Guest section DW <dwguest@win.tue.nl>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <20011227234104.B4528@win.tue.nl>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 27, 2001 at 07:51:01PM +0100, Stephan von Krawczynski   
wrote:                                                                
>                                                                     
> > I don't know. I tried once with                                   
> >                                                                   
> > 00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(rev d0)                                                              
> >                                                                   
> > and it did not work. I could definitely not write beyond the 32 GB
border. I                                                             
> > replaced the mobo then.                                           
>                                                                     
> Did you try setmax?                                                 
                                                                      
unfortunately not, I did not even know it existed before this thread. 
I must admit I have still not had a look at it, but on the other hand:
if it makes big IDE drives work on old mobo & bios, it may be a good  
idea to include its intelligence into the kernel, or not?             
Yes, I know that people nowadays tend to strip down _old_ stuff from  
the current sources, but I guess it is not a big loss in code size    
either, is it?                                                        
knock, knock .. hello IDE maintainer, how about a Xmas present ?      
:-)                                                                   
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
