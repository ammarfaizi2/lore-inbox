Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbUJ1LOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbUJ1LOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbUJ1LOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:14:00 -0400
Received: from smtp01.ibpmail.net ([194.151.203.101]:42458 "EHLO
	smtp01.ibpmail.net") by vger.kernel.org with ESMTP id S262966AbUJ1LN4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:13:56 -0400
In-Reply-To: <20041028110521.GB3207@stusta.de>
Subject: Re: kernel 2.6.9-bk4 make modules error when compile
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF14C1A08A.E91DA0D9-ONC1256F3B.003CF446-C1256F3B.003D3153@SOPARIND>
From: spu@corman.be
Date: Thu, 28 Oct 2004 13:08:18 +0200
X-MIMETrack: Serialize by Router on BACH/INT/SOPARIND(Release 6.0.3|September 26, 2003) at
 28/10/2004 12:05:28
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,

It's corrected on 2.6.9-bk5
Now I run with kernel 2.6.9-bk7

You can forgot this problem.

thank you

Adrian Bunk <bunk@stusta.de> a écrit sur 28/10/2004 13:05:21 :

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Wed, Oct 20, 2004 at 03:28:45PM +0200, stephane.purnelle@corman.be
wrote:
> >
> > Hi,
>
> Hi,
>
> > I submit this bug report :
> >
> > On function : <<typhoon_init_one>>
> > drivers/net/typhoon.c:2479: <<ops>> not declared (first utilisation on
this
> > function).
>
> I can't reproduce this is recent kernels.
>
> If it's still present in 2.6.10-rc1, please send your .config and the
> output of ./scripts/ver_linux .
>
> > thank you
>
> cu
> Adrian
>
> - --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.6 (GNU/Linux)
>
> iD8DBQFBgNJxmfzqmE8StAARAh9fAKCRqh8QMat+9bBhZv3MDs6D4iN6ewCfeh6u
> VBploe7z2THnPVXQul0aImE=
> =dqen
> -----END PGP SIGNATURE-----

