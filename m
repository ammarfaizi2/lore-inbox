Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135763AbRDTIWv>; Fri, 20 Apr 2001 04:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135824AbRDTIWm>; Fri, 20 Apr 2001 04:22:42 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:49936 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135763AbRDTIWb> convert rfc822-to-8bit; Fri, 20 Apr 2001 04:22:31 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Francois Romieu <romieu@cogenit.fr>,
        Oliver Teuber <teuber@core.devicen.de>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 10:22:26 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="unknown-8bit"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417184552.A6727@core.devicen.de> <20010418204021.A14531@se1.cogenit.fr>
In-Reply-To: <20010418204021.A14531@se1.cogenit.fr>
MIME-Version: 1.0
Message-Id: <01042010222601.06730@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 April 2001 20:40, Francois Romieu wrote:
> Hello,
>
> Oliver Teuber <teuber@core.devicen.de> écrit :
> [...]
>
> > 00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
> > 06) 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
> > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO] (rev
> > 07) 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo]
> > (rev 06) 00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
> > 00:09.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF
> > (rev 06) 00:0b.0 Multimedia audio controller: Ensoniq ES1371
> > [AudioPCI-97] (rev 06) 01:00.0 VGA compatible controller: nVidia
> > Corporation Riva TnT2 [NV5] (rev 11)
>
> Could you:
> - send me the motherboard version+bios revision ?
> - see if there exists an updated bios ?

I don't believe the motherboard or the BIOS have anything to do with, simply because 
I have been successfully using the SMC Etherpower with three different Motherboards 
- ASUS TX97-XE, MSI K7 Pro, Gigagbyte GA-71XE4 -
and (at least) three different kernels: 2.0.x, 2.2.18, 2.4.0. 
Something between 2.4.0 and 2.4.3 breaks the epic100 driver. That's it.

Cheers,
Stefan
-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
