Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRJUOFg>; Sun, 21 Oct 2001 10:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276075AbRJUOF0>; Sun, 21 Oct 2001 10:05:26 -0400
Received: from ns.ithnet.com ([217.64.64.10]:40971 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S276057AbRJUOFL>;
	Sun, 21 Oct 2001 10:05:11 -0400
Message-Id: <200110211405.QAA01146@webserver.ithnet.com>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 21 Oct 2001 16:05:38 +0100
Subject: Re: USB module ov511 dies after about 30 minutes
To: "Jeffrey H. Ingber" <axatax@thelittleman.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: Stephan von Krawczynski <skraw@ithnet.com>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
In-Reply-To: <1003605486.1616.65.camel@eleusis>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,                                                                 
>                                                                     
> The OV511 module in the kernel, is unfortunately, extremely old.    
                                                                      
I am currently testing the latest version.                            
Only one question about the topic:                                    
why is the latest driver not included in the kernel-tree? It seems not
very useful to include a currently broken driver at all. Can somebody 
give a hint to the maintainer, is he listening?                       
This seems to be a more global topic after all: I found out that the  
current kernel-driver for rocket serial cards is broken, too. It      
doesn't even recognise the pci cards (the pci code in it does not     
work).                                                                
Of course there is a working driver available at Control Inc. Why is  
it not included in the kernel? The one included is coming right from  
the stone-age.                                                        
Is there anybody actively checking the drivers for availability of new
versions? We obviously cannot trust on the authors themselves to      
commit them, may not be their fault or even job. Who is to do that in 
current maintaining actions? Linus, can you comment?                  
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
