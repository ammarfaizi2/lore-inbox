Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTJJC5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 22:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTJJC5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 22:57:22 -0400
Received: from gaia.cela.pl ([213.134.162.11]:35853 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262076AbTJJC5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 22:57:21 -0400
Date: Fri, 10 Oct 2003 04:57:10 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Adam Belay <ambx1@neo.rr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Query: PNP BIOS for 2.4.22
In-Reply-To: <20031009214028.GA12073@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0310100452130.1794-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To my knowledge, the ac series has the only up to date pnpbios patch for 2.4.
> You may, however, want to try the latest 2.6-test kernel which ships with an
> improved pnpbios driver.  Is there a particular PnPBIOS feature you are looking
> for in 2.4?  In other words which PnPBIOS services interest you?

I'm working on porting a hibernation patch from 2.4.9-34 (RH) to 2.4.22 
for toshiba laptops - which is based on pnpbios code.  Thus i'm pretty 
much interested in any pnpbios patch which a) works b) can be aplied with 
little fuss to 2.4.22 and c) doesn't contain extra frills (ie just 
pnpbios).  Unfortunately the latest RH kernels seem to have dropped 
pnpbios support and it's not present in the mainstream kernels, the best 
I've found so far is 2.4.22-ac - i'll probably strip it and see if it 
works (the stripping is done, will it work? we'll see tomorrow...)

Cheers,
MaZe.


