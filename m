Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbRL3XXG>; Sun, 30 Dec 2001 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285691AbRL3XW4>; Sun, 30 Dec 2001 18:22:56 -0500
Received: from ns.ithnet.com ([217.64.64.10]:35854 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285669AbRL3XWm>;
	Sun, 30 Dec 2001 18:22:42 -0500
Message-Id: <200112302316.AAA10906@webserver.ithnet.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Mon, 31 Dec 2001 00:16:57 +0100
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
To: timothy.covell@ashavan.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <200112301951.fBUJoxSr011753@svr3.applink.net>
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Saturday 29 December 2001 17:38, Stephan von Krawczynski wrote:  
> [Offtopic seti hints :-) ]                                          
> Ummm, on my Dual P-III (650MHz with 524988416 Bytes), my current    
Seti                                                                  
> efficiency is 5.35 CpF.   That's a tad high/slower than an Ultra    
Sparc IIi                                                             
> according to their stats.  So, it would appear that being SMP is    
hurting my                                                            
> performance a bit.   Unless that is that you meant to run a seti    
instance for                                                          
> each CPU?                                                           
                                                                      
Yes, exactly, use one seti per cpu and you will be happy :-)          
As far as I know they intended it this way.                           
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
