Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbRE2NGB>; Tue, 29 May 2001 09:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbRE2NFw>; Tue, 29 May 2001 09:05:52 -0400
Received: from jalon.able.es ([212.97.163.2]:18875 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262009AbRE2NFl>;
	Tue, 29 May 2001 09:05:41 -0400
Date: Tue, 29 May 2001 15:05:22 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Fabbione <fabbione@fabbione.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFF-TOPIC] 4 ports ETH cards
Message-ID: <20010529150522.A24682@werewolf.able.es>
In-Reply-To: <3B135549.19CF8965@fabbione.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3B135549.19CF8965@fabbione.net>; from fabbione@fabbione.net on Tue, May 29, 2001 at 09:52:41 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.29 Fabbione wrote:
> Hi all,
> 	sorry for the offtopic msg.
> 
> Can someone point me to a 4 ports fast/eth card solution for linux?
> 
> I found some cards based on the DEC 21*4* chips but when
> I asked for more details I got a strange answer from the reseller
> like that this card is able to work only half-duplex and the chip has
> only one mac-address for the 4 eth cards (really strange).
> 

Adaptec has the DuraLAN product (aka starfire). Look in their web page.
Drivers are included in the kernel; for more info, look in:
http://www.scyld.com/network/starfire.html

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac3 #1 SMP Mon May 28 19:37:02 CEST 2001 i686
