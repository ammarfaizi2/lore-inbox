Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbSK1R0Z>; Thu, 28 Nov 2002 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSK1R0Z>; Thu, 28 Nov 2002 12:26:25 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:60649 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266210AbSK1R0Y>;
	Thu, 28 Nov 2002 12:26:24 -0500
Date: Thu, 28 Nov 2002 17:31:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Sebastian Benoit <benoit-lists@fb12.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
Message-ID: <20021128173120.GC930@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Sebastian Benoit <benoit-lists@fb12.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com> <20021128111528.A28437@turing.fb12.de> <1038500743.10021.1.camel@irongate.swansea.linux.org.uk> <20021128200207.A23822@jurassic.park.msu.ru> <1038505301.10168.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038505301.10168.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 05:41:41PM +0000, Alan Cox wrote:
 > > It moves most obvious stuff (northbridges quirks) to the proper
 > > place (arch/i386/pci/fixups.c).
 > What about x86_64 ?
 > Can the x86_64 folks verify these are not going to appear in x86_64
 > systems at all ?

I would hope no-one has the idea to wire a hammer up to a
triton/natoma chipset.  The VIA ones are more questionable.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
