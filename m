Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRH0NxK>; Mon, 27 Aug 2001 09:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271723AbRH0NxB>; Mon, 27 Aug 2001 09:53:01 -0400
Received: from mx2.port.ru ([194.67.57.12]:46094 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S271719AbRH0Nwo>;
	Mon, 27 Aug 2001 09:52:44 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109261815.f8QIFGJ10542@vegae.deep.net>
Subject: Re: 2.4.x & PPP-or-IP-or-TCP
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 26 Sep 2001 18:15:15 +0000 (UTC)
Cc: lkml@vegae.deep.net
In-Reply-To: <E15bJwl-0003gu-00@the-village.bc.nu> from "Alan Cox" at Aug 27, 2001 11:48:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Alan Cox wrote:"
> 
> >      for interested and wanting to help:
> >  http://tech9.net/rml/linux/patch-rml-2.4.8-ac12-preempt-kernel-1
> >     just cant get. no way. period.
> 
> I would investigate your modem or serial settings. I can pull that file
> flat out over Linux 2.4.x ppp. 
> 
    dont quite understand that sentence(still hard with english), 
 but here is requested(?) data:

    Zyxel 56k Omni - russian version.

[root@vegae:/usr/src/linux]# setserial /dev/ttyS1
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3, Flags: spd_hi low_latency

AT Q0 V1 E1 S0=0 &C1 &D2 S11=55 +FCLASS=0 L0 M0 - but you can try whatever
do you like - it is seem to be not even modem-dependant


