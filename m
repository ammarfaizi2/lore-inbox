Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbUJ1LGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUJ1LGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUJ1LGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:06:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57096 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262967AbUJ1LFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:05:53 -0400
Date: Thu, 28 Oct 2004 13:05:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: stephane.purnelle@corman.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.9-bk4 make modules error when compile
Message-ID: <20041028110521.GB3207@stusta.de>
References: <OF35EC4215.1E87AF6A-ONC1256F33.0049A434-C1256F33.004A1F39@SOPARIND>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <OF35EC4215.1E87AF6A-ONC1256F33.0049A434-C1256F33.004A1F39@SOPARIND>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, Oct 20, 2004 at 03:28:45PM +0200, stephane.purnelle@corman.be wrote:
> 
> Hi,

Hi,

> I submit this bug report :
> 
> On function : <<typhoon_init_one>>
> drivers/net/typhoon.c:2479: <<ops>> not declared (first utilisation on this
> function).

I can't reproduce this is recent kernels.

If it's still present in 2.6.10-rc1, please send your .config and the 
output of ./scripts/ver_linux .

> thank you

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgNJxmfzqmE8StAARAh9fAKCRqh8QMat+9bBhZv3MDs6D4iN6ewCfeh6u
VBploe7z2THnPVXQul0aImE=
=dqen
-----END PGP SIGNATURE-----
