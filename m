Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSLZTUI>; Thu, 26 Dec 2002 14:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSLZTUI>; Thu, 26 Dec 2002 14:20:08 -0500
Received: from hunnerberg.nijmegen.internl.net ([217.149.192.32]:34555 "EHLO
	hunnerberg.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S263333AbSLZTUH>; Thu, 26 Dec 2002 14:20:07 -0500
Date: Thu, 26 Dec 2002 20:28:19 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
Message-ID: <20021226192818.GA1505@iapetus.localdomain>
References: <1040815160.533.6.camel@devcon-x> <20021225115820.GB7348@louise.pinerecords.com> <20021226123710.GA2442@iapetus.localdomain> <20021226132228.GE7348@louise.pinerecords.com> <20021226164229.GA26413@iapetus.localdomain> <20021226173528.GF7348@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021226173528.GF7348@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 06:35:28PM +0100, Tomas Szepe wrote:
> 
> Fair enough.  Can you give me your PCI ids, Promise BIOS version

Ultra100TX2 BIOS version is 2.20.0.11

dmesg says:
PDC20268: IDE controller on PCI bus 00 dev 90
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xe2000000
PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.

-- 
Frank
