Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283045AbRLQXSM>; Mon, 17 Dec 2001 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283048AbRLQXSC>; Mon, 17 Dec 2001 18:18:02 -0500
Received: from ns.ithnet.com ([217.64.64.10]:52496 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S283045AbRLQXRz>;
	Mon, 17 Dec 2001 18:17:55 -0500
Message-Id: <200112172317.AAA16715@webserver.ithnet.com>
Date: Tue, 18 Dec 2001 00:17:45 +0100
Subject: Re: [PATCH] 2.4.16 Fix NULL pointer dereferencing in =?iso-8859-1?q?agpgart=5Fbe.c?=
In-Reply-To: <1008616583.1705.0.camel@phantasy>
To: Robert Love <rml@tech9.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        Yoshiki Hayashi <yoshiki@xemacs.org>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
From: Stephan von Krawczynski <skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2001-12-17 at 12:55, Marcelo Tosatti wrote:                 
>                                                                     
> > Well, Stephan, if you could send me only the part which fixes the 
oops for                                                              
> > 2.4.17 then I'll be happy.                                        
                                                                      
Robert's patch is it. Plain and simple, was my approach too, but it   
turned out, Nics was cleaner.                                         
Anyway, I guess Nic will re-submit it based on the non-oopsing 2.4.17 
:-)                                                                   
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
                                                                      
