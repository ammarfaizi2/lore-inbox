Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269986AbRHJT3V>; Fri, 10 Aug 2001 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269984AbRHJT3L>; Fri, 10 Aug 2001 15:29:11 -0400
Received: from mail.intrex.net ([209.42.192.246]:23302 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S269980AbRHJT2z>;
	Fri, 10 Aug 2001 15:28:55 -0400
Date: Fri, 10 Aug 2001 15:29:46 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Cc: jkern@numeritech.com
Subject: 2.4.7 & 2.4.8-pre8 fail to boot
Message-ID: <20010810152946.A6055@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I have some dual CPU P3 machines that I can not get to boot.  I am able
to get 2.4.5 to work.  Here is a description of what happens during boot:

> Here is the ouput I wrote down from the boot output.
> 
> Before bogocount - setting activated=1
> Boot done.
> Eabling IO-APIC IRQs
> ... changing IO-APIC physical APIC-IO to 2 ..OK
> Synchronizing Arb IDs
> ..TIMER: vector=31 pin1=2 pin2=0
> 
> at this point it hangs..usually with a blank screen.

Does anyone have any idea whats going on or how to get around this?

Thanks,

Jim
