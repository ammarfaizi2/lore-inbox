Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVJCFPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVJCFPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVJCFPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:15:52 -0400
Received: from smtpout6.uol.com.br ([200.221.4.197]:754 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S1750834AbVJCFPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:15:51 -0400
Date: Mon, 3 Oct 2005 02:15:49 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051003051549.GD5576@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <20050928084330.GC24760@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050928084330.GC24760@viasys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ville.

On Sep 28 2005, Ville Herva wrote:
> You may be running into this problem:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.2/0574.html
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/1727.html
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-01/1048.html
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99889965423508&w=2               
> 
> (A google search will turn up more.)

Thank you very much for these links. It seems that I may be not alone
here, unfortunately. :-(

> Placing network card to a different PCI slot helped somewhat as did
> upgrading the bios.

I have not played with the network cards, but I have already upgraded
the BIOS firmware to the latest version that I could find (in the hope
that I could get the Duron 1.3GHz being actually identified as such,
instead of operating at 1.1GHz).

> It seemed to be a KT133 Northbridge DMA issue. My impression is that
> KT133 is utter crap period.

Well, is this a problem particular with KT133 or is this a generic thing
with VIA chipsets?

I'm interested because I don't know the other chipset options that are
Open Source friendly---it seems that Nvidia-based ones have to have
reverse-engineered drivers (e.g., forcedeth), which is quite bad, IMO.

I'm intenging to get another system as soon as the dust settles and
x86_64 and SATA drives become mainstream enough to be readily available
here in Brazil for reasonable prices.

But, then, I'd be concerned in getting a chipset from an company that
plays nice with Linux (and the *BSDs too, for that matter). Opinions are
more than welcome.


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
