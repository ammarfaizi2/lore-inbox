Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263404AbRFNRI5>; Thu, 14 Jun 2001 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbRFNRIr>; Thu, 14 Jun 2001 13:08:47 -0400
Received: from cr11220-b.lndn1.on.wave.home.com ([24.114.20.59]:6660 "HELO
	megaepic.com") by vger.kernel.org with SMTP id <S263404AbRFNRId>;
	Thu, 14 Jun 2001 13:08:33 -0400
From: ssh@megaepic.com
Date: Thu, 14 Jun 2001 13:08:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 kernel crash while using tcpdump+iptraf
Message-ID: <20010614130828.C5279@megaepic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What kind of network card, and what network driver?

I've got 3 NICs:

ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 c0 df 64 7b d5
eth0: NE2000 found at 0x300, using IRQ 9.
NE*000 ethercard probe at 0x340: 00 80 c8 64 df db
eth1: NE2000 found at 0x340, using IRQ 5.
loop: loaded (max 8 devices)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 12 for device 00:0b.0
eth2: RealTek RTL-8029 found at 0xe400, IRQ 12, 00:C0:F0:2B:C9:AA.
  
I'm not exactly sure what brand the ISA ones are... if
it's really relevent I guess I could take the cards out and inspect
the chipsets :)

Mathew Johnston
