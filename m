Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288651AbSAIAgM>; Tue, 8 Jan 2002 19:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288653AbSAIAgB>; Tue, 8 Jan 2002 19:36:01 -0500
Received: from 48ip31.craterhs.centpoint.k12.or.us ([198.237.137.31]:18955
	"HELO mail.district6.org") by vger.kernel.org with SMTP
	id <S288651AbSAIAf6>; Tue, 8 Jan 2002 19:35:58 -0500
Subject: Re: Problem with network
From: Aaron Blew <aaron.blew@district6.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <NFBBJJFKOKJEMFAEIPPJCEAHCBAA.chandrasekhar.nagaraj@patni.com>
In-Reply-To: <NFBBJJFKOKJEMFAEIPPJCEAHCBAA.chandrasekhar.nagaraj@patni.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Jan 2002 16:39:23 -0800
Message-Id: <1010536764.21489.3.camel@workmonkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may try saying NO to the "Plug-and-Play OS installed" toggle in your
BIOS

Good luck,
-Aaron

On Tue, 2002-01-08 at 04:53, Chandrasekhar wrote:
> 
> 
> Hi,
> 
> 
> We are facing a problem regarding the network communication.
> System: Linux Kernel 2.4.7 with rmk2 and np1 patch on Assabet board.
> Problem: After setting all the required and necessary network parameters and
> running the utlility ifconfig we get the following error message
> SIOCSIFHWADDR: Device or resource busy
> But the IP Address, Netmask and Broadcast addressess are properly set.
> After this if we run ftp we get the following error message
> ftp: NETDEV WATCHDOG: eth0 timeout
> We tried increasing the timeout period but in vain.
> 
> Pls Suggest
> 
> Regards
> Chandrasekhar
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


