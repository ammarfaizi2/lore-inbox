Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSHARpW>; Thu, 1 Aug 2002 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSHARpW>; Thu, 1 Aug 2002 13:45:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9969 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316519AbSHARpV>; Thu, 1 Aug 2002 13:45:21 -0400
Subject: Re: Kernel panic on Dual Athlon MP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kwijibo@zianet.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D49745B.6070108@zianet.com>
References: <200208011224.g71COrW05657@pc02.e18.physik.tu-muenchen.de>
	<1028212424.14865.44.camel@irongate.swansea.linux.org.uk> 
	<3D49745B.6070108@zianet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 20:05:53 +0100
Message-Id: <1028228753.14871.88.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 18:48, kwijibo@zianet.com wrote:
> >My board won't even POST with a tg3 card in it. With a newer BIOS it
> >
> Great, I had plans to put a tg3 card in my dual Athlon box.
> Do you know if this is a Tiger board only problem?  I have
> the Thunder S2462UNG with just the MP chipset.  How
> new of a bios?  I don't plan to use the tg3 card on the box
> until 2.4.19 comes out due to the important fixes in it for
> the tg3.

The BIOS in mine is pretty old and newer BIOSes fix it. As I understand
it this was caused by PCI misconfiguration in the BIOS. I've not tested
current compatibility myself so I'm going on what I've heard there.

> I have 2 3ware 7850's on a dual Athlon MP 1900 box and I have
> no problems yet with it.  I am about to increase the network to
> gigi speed and I hope it has no problems.  Currently this is
> with 2.4.18.

Good to hear


