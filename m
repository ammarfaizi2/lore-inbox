Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136597AbREAJMw>; Tue, 1 May 2001 05:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136598AbREAJMm>; Tue, 1 May 2001 05:12:42 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:7349
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S136597AbREAJMb>; Tue, 1 May 2001 05:12:31 -0400
Message-ID: <3AEE7DDD.5080004@fugmann.dhs.org>
Date: Tue, 01 May 2001 11:11:57 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: "Clayton, Mark" <mclayton@netplane.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CANBus driver.
In-Reply-To: <87009604743AD411B1F600508BA0F95994C79F@XOVER.dedham.mindspeed.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark.

Thanks for your reply - its nice to hear the there is some interrest in 
out project.

Clayton, Mark wrote:

> I am always interested in CAN stuff on Linux.  Where can I find
> more info in the card you plan to use?  

See: http://www.kvaser.se

We will contact Kvaser to get the technical Specification. I cannot 
guarantee that we will be allowed to publish it, but if we are and you 
are interrested, i can send you a link when and if we get it.


I don't have many ISA
> slots left, so if decide to find a different card, make it PCI.
> I have a Infineon based reference board at home around which I 
> plan to develop a few software projects.

We have no influence on the card itself, I'm afaid. But we will stridt 
to make it very easy to change the hardware driver.

The driver we want to implement, is actually several drivers.
Since the CANBus is a bus, it is natual (for us) to implement it as 
such, so that it will be possible to load drivers on top of the hardware 
driver, which can communicate with specific hardware on the bus.


> 
> BTW, there are CAN drivers for several chip.  I have urls at home.
> I can send them to you in a few days.  Assuming I still have them.

I'm still very interrested.


> 
> Mark
> --
> Mark Clayton                       mclayton@netplane.com
> NetPlane Systems Inc               http://www.netplane.com
> 888 Washington Street              Tel: (781) 329-3200 x5355
> Dedham MA 02026                    Fax: (781) 329-4148
> --
> [root@hjinc mclayton] /sbin/insmod stddisclaimer.o
> 

>

Regards
Anders Fugmann

 

