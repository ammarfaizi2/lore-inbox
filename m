Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVCXCn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVCXCn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVCXCn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:43:26 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:26265 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262986AbVCXCnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:43:22 -0500
Date: Thu, 24 Mar 2005 13:43:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Shawn Smith" <shawn.smith@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: apm poweroff bug
Message-Id: <20050324134316.30c1ba67.sfr@canb.auug.org.au>
In-Reply-To: <1111628774.8c93a03cshawn.smith@myrealbox.com>
References: <1111628774.8c93a03cshawn.smith@myrealbox.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Mar_2005_13_43_16_+1100_na_VIUEas7lhk27u"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__24_Mar_2005_13_43_16_+1100_na_VIUEas7lhk27u
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Mar 2005 17:46:14 -0800 "Shawn Smith" <shawn.smith@myrealbox.com=
> wrote:
>
> After giving a halt command, the system is normal until it gives the
> powerdown message, and then there is a dump of error messages. =20

You have a broken BIOS, please use the "apm=3Drealmode_power_off" kernel
command line switch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__24_Mar_2005_13_43_16_+1100_na_VIUEas7lhk27u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCQilE4CJfqux9a+8RAp8bAJ99cUo1/I06TE4/WYqEHtmee92zpgCfd7r4
AAJZeCfbWsbhCFGe8OQ37aQ=
=6piP
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Mar_2005_13_43_16_+1100_na_VIUEas7lhk27u--
