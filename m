Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRJUBuS>; Sat, 20 Oct 2001 21:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275110AbRJUBuI>; Sat, 20 Oct 2001 21:50:08 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:35200 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S275098AbRJUBt4>; Sat, 20 Oct 2001 21:49:56 -0400
Message-Id: <200110210150.LAA14611@isis.its.uow.edu.au>
Date: Sun, 21 Oct 2001 11:50:22 +1000
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [198.142.194.161]
From: Sean Van Buggenum <sv24@uow.edu.au>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Subject: kernel or std c++ libraries
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,                                                                  
I think there's a bug with .. i guess the linux kernel... or standard 
c++ libraries included with recent installations of mandrake and      
redhat.                                                               
I've come to this conclusion because something i've written in c++,   
very basic stuff... ( using the function seekg() from the fstream     
library ) works fine on unix installations that i've used, but not on 
any of the linux installations i've tried on My computer. All the code
                                                                      
does is open a binary file with the file pointer set for however many 
positions from the END of the file (it works when i use the start of  
the file ) .. and try to read from there.                             
i've used kernel 2.2.16.... and it didn't work then.. i've recently   
installed mandrake 8.1 and thought that with the newer kernel         
included (hoped) it was just a bug in the redhat installation that i  
had previously. But it still doesn't work.                            
Is it a bug in the software ? or something to do with my hardware..is 
what i'd like to know.. i'm using a intel celeron 600 processor.. if  
that'd be important.                                                  
                                                                      
sean van buggenum                                                     
sv24@uow.edu.au                                                       
                                                                      
