Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSEWQMW>; Thu, 23 May 2002 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316936AbSEWQMV>; Thu, 23 May 2002 12:12:21 -0400
Received: from relay2.zonnet.nl ([62.58.50.38]:53491 "EHLO relay2.zonnet.nl")
	by vger.kernel.org with ESMTP id <S316935AbSEWQMR>;
	Thu, 23 May 2002 12:12:17 -0400
Subject: Re: kernel 2.4.19-pre8 reboots instead of halt and 3com messages
From: Hilbert Barelds <hilbert@hjb-design.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205231345400.23578-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 May 2002 18:10:54 +0200
Message-Id: <1022170254.1806.0.camel@calvin.hjblocal.nl>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-23 at 13:48, Zwane Mwaikambo wrote:
> On Thu, 23 May 2002 hilbert@hjb-design.com wrote:
> 
> > PS The 3com card complains about a "transpoder" x times.
> 
> Can you get the exact error message? Is the driver modular?

The exact error message is:
PCI: Found IRQ 12 for device 00:0a.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c900 Boomerang 10Mbps Combo at 0xdc00. Vers LK1.1.17
phy=0, phyx=24, mii_status=0xffff
phy=1, phyx=0, mii_status=0xffff
phy=2, phyx=1, mii_status=0xffff
phy=3, phyx=2, mii_status=0xffff
phy=4, phyx=3, mii_status=0xffff
phy=5, phyx=4, mii_status=0xffff
phy=6, phyx=5, mii_status=0xffff
phy=7, phyx=6, mii_status=0xffff
phy=8, phyx=7, mii_status=0xffff
phy=9, phyx=8, mii_status=0xffff
phy=10, phyx=9, mii_status=0xffff
phy=11, phyx=10, mii_status=0xffff
phy=12, phyx=11, mii_status=0xffff
phy=13, phyx=12, mii_status=0xffff
phy=14, phyx=13, mii_status=0xffff
phy=15, phyx=14, mii_status=0xffff
phy=16, phyx=15, mii_status=0xffff
phy=17, phyx=16, mii_status=0xffff
phy=18, phyx=17, mii_status=0xffff
phy=19, phyx=18, mii_status=0xffff
phy=20, phyx=19, mii_status=0xffff
phy=21, phyx=20, mii_status=0xffff
phy=22, phyx=21, mii_status=0xffff
phy=23, phyx=22, mii_status=0xffff
phy=24, phyx=23, mii_status=0xffff
phy=25, phyx=25, mii_status=0xffff
phy=26, phyx=26, mii_status=0xffff
phy=27, phyx=27, mii_status=0xffff
phy=28, phyx=28, mii_status=0xffff
phy=29, phyx=29, mii_status=0xffff
phy=30, phyx=30, mii_status=0xffff
phy=31, phyx=31, mii_status=0xffff
  ***WARNING*** No MII transceivers found!

Reguards,

Hilbert

