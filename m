Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbSKUPBs>; Thu, 21 Nov 2002 10:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbSKUPBs>; Thu, 21 Nov 2002 10:01:48 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1670 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266702AbSKUPBr>; Thu, 21 Nov 2002 10:01:47 -0500
Subject: Re: A7M266-D
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jan <jan@seismo.ifg.ethz.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DDCEEC6.5030806@seismo.ifg.ethz.ch>
References: <3DDCEEC6.5030806@seismo.ifg.ethz.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 15:37:49 +0000
Message-Id: <1037893069.7660.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 14:33, jan wrote:
> dear list,
> 
> i have an A7M266-D board with two AMD Athlon MP 2000+ on it.
> Unfortunately I am unable to compile the correct driver for the AM7441 
> IDE Controller (using 2.4.19)
> I always get this under SuSE :
> 
> AMD7441: detected chipset, but driver not compiled in!
> 
> When using a precompiled SUSE or RedHat Kernel it gets recognized.

Base 2.4 doesnt have a driver for the 7441. The -ac tree does and it
seems SuSE also picked up the newer driver for it.

