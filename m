Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRHWMc5>; Thu, 23 Aug 2001 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272247AbRHWMci>; Thu, 23 Aug 2001 08:32:38 -0400
Received: from housing11.berlin3.powerweb.de ([62.67.209.22]:19216 "EHLO
	housing11.berlin3.powerweb.de") by vger.kernel.org with ESMTP
	id <S272244AbRHWMcQ>; Thu, 23 Aug 2001 08:32:16 -0400
Message-ID: <003001c12bd0$b5b64da0$ce01a8c0@CPL01>
From: "compulan" <astilley@compulan.de>
To: "Axel Siebenwirth" <axel@hh59.org>, "Axel" <axel@rayfun.org>
Cc: "Kernel Ml" <linux-kernel@vger.kernel.org>,
        "Realtek Ml" <realtek@scyld.com>
In-Reply-To: <Pine.LNX.4.33.0108231414350.16256-100000@neon.hh59.org>
Subject: Re: [realtek] Realtek 8139C: NETDEV WATCHDOG transmit timeout
Date: Thu, 23 Aug 2001 14:37:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you stop sending this to this address, it would be greatly
appreciated. thank you. it has been going on for two days now, and we have
no use for this information. thank you.
----- Original Message -----
From: Axel Siebenwirth <axel@hh59.org>
To: Axel <axel@rayfun.org>
Cc: Kernel Ml <linux-kernel@vger.kernel.org>; Realtek Ml <realtek@scyld.com>
Sent: Thursday, August 23, 2001 2:16 PM
Subject: Re: [realtek] Realtek 8139C: NETDEV WATCHDOG transmit timeout


> I got myself the latest version of rtl8139-diag and it gave me different
> output in the chip registers! there are different values at 0x040.
>
> axel
>
> rtl8139-diag.c:v2.04 8/08/2001 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> Index #1: Found a RealTek RTL8139 adapter at 0xf800.
> The RealTek chip appears to be active, so some registers will not be read.
> To see all register values use the '-f' flag.
> RealTek chip registers at 0xf800
>  0x000: 26843000 0000470b 80040000 40000000 9008a03c 9008a054 9008a054
> 9008a03c
>  0x020: 03096000 03096600 03096c00 03097200 02f80000 0d0a0000 42dc42cc
> 0000c07f
>  0x040: 74000600 0e00f78e 951264c7 00000000 000d1000 00000000 008cd108
> 00100000
>  0x060: 1000f00f 01e1782d 00000000 00000000 00000005 000f77c0 b0f243b9
> 7a36d743.  No interrupt sources are pending.
>  The chip configuration is 0x10 0x0d, MII half-duplex mode.
>  The RTL8139 does not use a MII transceiver.
>  It does have internal MII-compatible registers:
>    Basic mode control register   0x782d.
>    Basic mode status register    0x1000.
>    Autonegotiation Advertisement 0x01e1.
>    Link Partner Ability register 0x0000.
>    Autonegotiation expansion     0x0000.
>    Disconnects                   0x0000.
>    False carrier sense counter   0x0000.
>    NWay test register            0x0005.
>    Receive frame error count     0x0000.
>
>
>
>
> _______________________________________________
> realtek mailing list
> realtek@scyld.com
> http://www.scyld.com/mailman/listinfo/realtek
>

