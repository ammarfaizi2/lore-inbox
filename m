Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265552AbRF2F3y>; Fri, 29 Jun 2001 01:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbRF2F3o>; Fri, 29 Jun 2001 01:29:44 -0400
Received: from ns.asml.nl ([195.109.200.66]:7312 "EHLO pollux.asml.nl")
	by vger.kernel.org with ESMTP id <S265552AbRF2F3h>;
	Fri, 29 Jun 2001 01:29:37 -0400
From: Tim Timmerman <Tim.Timmerman@asml.com>
Message-ID: <15164.4642.621532.532854@asml.nl>
Date: Fri, 29 Jun 2001 07:29:06 +0200
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG with 2.4.5
In-Reply-To: <3B397659.816CF0A3@uow.edu.au>
In-Reply-To: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>
	<15161.28095.801407.427346@asml.nl>
	<3B397659.816CF0A3@uow.edu.au>
X-Mailer: VM 6.90 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <andrewm@uow.edu.au> writes:

Andrew> Tim Timmerman wrote:
>> 
>> >>>>> "kees" == kees  <kees@schoen.nl> writes:
>> 
kees> Hi,
>> 
kees> I tried 2.4.5 but after a couple of hours I lost all network
kees> connectivety.  The log shows:
>> <snip>
>> Can I just add a me too here ?
>> 
>> System: Abit BP6, Dual Celeron, Ne2k-pci, usb ohci and
>> scanner; 128 Mb Ram, Nvidia TNT2 graphics. Kernel 2.4.5
<snip>

Andrew> Probable fixes include booting with the `noapic' option,
Andrew> running -ac kernels or applying Maciej's APIC workaround
Andrew> patch.  There's a copy at http://www.uow.edu.au/~andrewm/linux/apic.txt
Andrew> -
   Didn't check the patch, but went straight for 2.4.5-ac20... No hangs,
   and better performance than before.

   TimT. 
   

-- 
tim.timmerman@asml.nl                              040-2683613
timt@timt.org   Voodoo Programmer/Keeper of the Rubber Chicken
Whatever happened to preparations A through G?

