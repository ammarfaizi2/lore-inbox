Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUIHN7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUIHN7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUIHN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:57:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:28629 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267841AbUIHN4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:56:39 -0400
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
From: Paul Larson <plars@linuxtestproject.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Roland Dreier <roland@topspin.com>,
       "David S. Miller" <davem@davemloft.net>, Michael.Waychison@Sun.COM,
       Brian.Somers@Sun.COM, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040908073412.3b7c9388@localhost>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	 <200408162049.FFF09413.8592816B@anet.ne.jp>
	 <20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	 <20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	 <20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	 <20040830161126.585a6b62.davem@davemloft.net>
	 <1094238777.9913.278.camel@plars.austin.ibm.com> <4138C3DD.1060005@sun.com>
	 <52acw7rtrw.fsf@topspin.com> <20040903133059.483e98a0.davem@davemloft.net>
	 <52ekljq6l2.fsf@topspin.com> <20040907133332.4ceb3b5a@localhost>
	 <52isapkg9z.fsf@topspin.com>  <20040908073412.3b7c9388@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Apu0Q0E4vh9PaXKHhIAH"
Message-Id: <1094651744.9913.280.camel@plars.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 08:55:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Apu0Q0E4vh9PaXKHhIAH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've had no success on any of the blades or bladecenters I've tried it
on.

On Wed, 2004-09-08 at 07:34, Jake Moilanen wrote:
> > With the 3.9 tg3 driver, neither SoL nor the real network seems to
> > ever come back.  As far as I can tell, the network is dead (and
> > without SoL there's no way for me to see what happens to the kernel).
> >=20
> > Have you had success with the latest tg3 on JS20?
>=20
> I've had mixed results.  On some of my blades it never works.  On others
> it will come up every third attempt or so.
>=20
> Thanks,
> Jake

--=-Apu0Q0E4vh9PaXKHhIAH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPw9gbkpggQiFDqcRAtp8AJ9etEwaEFI4L1M2RRY9LUUUB/YDvQCeOVVa
lWTdxs3wJze6l0eTKBRx04A=
=hhoZ
-----END PGP SIGNATURE-----

--=-Apu0Q0E4vh9PaXKHhIAH--

