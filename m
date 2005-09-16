Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbVIPUKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbVIPUKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbVIPUKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:10:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6893 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161281AbVIPUKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:10:14 -0400
Message-Id: <200509161957.j8GJvZMR019447@inti.inf.utfsm.cl>
To: Bodo Eggert <7eggert@gmx.de>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts 
In-Reply-To: Message from Bodo Eggert <7eggert@gmx.de> 
   of "Fri, 16 Sep 2005 20:57:31 +0200." <Pine.LNX.4.58.0509162029470.5708@be1.lrz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 16 Sep 2005 15:57:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@gmx.de> wrote:
> On Fri, 16 Sep 2005, H. Peter Anvin wrote:
> > Bodo Eggert wrote:

[...]

> > > Unless you can guarantee every editor to correctly handle this case, all
> > > usage of 8-bit-characters should be disabled - NOT!

> > Actually, it's quite easy to avoid problems by using UTF-8 consistently. 
> >    The 8-bit characters are oddballs and need to be treated specially, 
> > but look, guys, it's 2005 - UTF-8 should be the norm, not the exception.

Right.

> It should, but as long as old programs are still around, we'll have both 
> and need a marker to distinguish them. Otherwise we'll be stuck with
> legacy scripts for a long time.

Please. Let people who mess with legacy stuff suffer, don't make everybody
else (and forevermore!) pay the price.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
