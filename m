Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSK1SPE>; Thu, 28 Nov 2002 13:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbSK1SPE>; Thu, 28 Nov 2002 13:15:04 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:46231 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266640AbSK1SPD>; Thu, 28 Nov 2002 13:15:03 -0500
Subject: Re: drivers/pci/quirks.c / Re: Linux v2.5.50
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Sebastian Benoit <benoit-lists@fb12.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021128173007.GB930@suse.de>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
	<20021128111528.A28437@turing.fb12.de>
	<1038500743.10021.1.camel@irongate.swansea.linux.org.uk>
	<20021128200207.A23822@jurassic.park.msu.ru>  <20021128173007.GB930@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 18:54:12 +0000
Message-Id: <1038509652.10168.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-28 at 17:30, Dave Jones wrote:
> On Thu, Nov 28, 2002 at 08:02:07PM +0300, Ivan Kokshaysky wrote:
> 
>  > +static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
>  > +{
>  > +	printk(KERN_INFO "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.\n");
>  > +	/* Mae rhaid in i beidio a edrych ar y lleoliad I/O hyn */
> 
> You gotta be kidding me ?  Amusing as the welsh language may be,
> comments really should be readable to more than 0.01% of those likely
> to be looking at them.

Some people have no sense of humour.


