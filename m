Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131484AbRANCO2>; Sat, 13 Jan 2001 21:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131517AbRANCOS>; Sat, 13 Jan 2001 21:14:18 -0500
Received: from jalon.able.es ([212.97.163.2]:719 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131484AbRANCOO>;
	Sat, 13 Jan 2001 21:14:14 -0500
Date: Sun, 14 Jan 2001 03:14:06 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call for testers: ne2k-pci and io apic
Message-ID: <20010114031406.A879@werewolf.able.es>
In-Reply-To: <200101131237.f0DCb8g15518@flint.arm.linux.org.uk> <3A6071C2.47E8418A@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A6071C2.47E8418A@colorfullife.com>; from manfred@colorfullife.com on Sat, Jan 13, 2001 at 16:18:26 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.13 Manfred Spraul wrote:
> 
> Any volunteers with ne2k-pci cards and other motherboards that include
> an io apic (e.g. all Intel motherboards that use an IO Controller Hub,
> Via Apollo Pro133, Pro133A, KX133)?
> 

In my case, (440GX/BX, PIIX4), network goes off (both with a ping-flood
or some web browsing) with a message:

Jan 14 03:01:25 werewolf kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 14 03:01:57 werewolf last message repeated 19 times


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac9 #2 SMP Sun Jan 14 01:46:07 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
