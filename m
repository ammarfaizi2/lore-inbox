Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264843AbRGCQlr>; Tue, 3 Jul 2001 12:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbRGCQlh>; Tue, 3 Jul 2001 12:41:37 -0400
Received: from father.pmc-sierra.bc.ca ([216.241.224.13]:17055 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id <S264843AbRGCQlX>; Tue, 3 Jul 2001 12:41:23 -0400
Message-ID: <9DC5E2ABE65BD54CA9088DA3194461D60486C625@BBY1EXM01>
From: PMC-Sierra Apps Support <Apps@pmc-sierra.com>
To: "'Green'" <greeen@iii.org.tw>,
        LinuxEmbeddedMailList <linux-embedded@waste.org>,
        LinuxKernelMailList <linux-kernel@vger.kernel.org>,
        MipsMailList <linux-mips@fnet.fr>
Subject: RE: RF driver!!
Date: Tue, 3 Jul 2001 09:45:44 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Green,
Thank you for your request for support on PMC-Sierra products. In order to serve you better, we require some additional contact information. This information will be used to direct your request to the appropriate factory or field applications engineer, and to help us track your support incident.

Could you please reply to me with the following information:

*	Full Name
*	Company Name
*	Company Location (city)
*	Mailing Address (optional)
*	Phone Number (optional)
*	Fax Number (optional)

Thanks, 

Applications Assistant 
PMC-Sierra, Inc. 
Ph: (604) 415-4533 
Fax: (604) 415-6206 
apps@pmc-sierra.com 
http://www.pmc-sierra.com/ <http://www.pmc-sierra.com/>  

-----Original Message-----
From: Green [mailto:greeen@iii.org.tw]
Sent: Monday, July 02, 2001 11:56 PM
To: LinuxEmbeddedMailList; LinuxKernelMailList; MipsMailList
Subject: RF driver!!


Hi all,
 
I am porting a pcmcia rf driver (which worked on kernel 2.2.12)
to kernel 2.4.0 on my MIPS machine.
 
1. I found there are some diffenence in netdevice.h.
    The structure device changed to net_device.
 
2. And the tbusy, start, interrupt were gone with 
    the use of the netif_start_queue, netif_stop_queue,
    netif_wake_queue and related functions.
 
How do I use these functions to modify the 2.2.12 rf driver to 2.4.0 ??
 
Thanks,
 
Green


