Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUATORP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 09:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbUATORP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 09:17:15 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:4051 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265546AbUATORN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 09:17:13 -0500
Subject: Re: ALSA vs. OSS
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hznci7lxg.wl@alsa2.suse.de>
References: <1074532714.16759.4.camel@midux>
	 <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org>
	 <1074536486.5955.412.camel@castle.bigfiber.net>
	 <200401201046.24172.hus@design-d.de> <400D2AB2.7030400@borgerding.net>
	 <1074607389.19502.4.camel@midux>  <s5hznci7lxg.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kuWmNYV5+ZkQ6HyzoE4z"
Message-Id: <1074608233.19614.3.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 16:17:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kuWmNYV5+ZkQ6HyzoE4z
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-20 at 16:07, Takashi Iwai wrote:
> <..snip..>
> what kernel messages did you get?
>=20
No messages anywhere, it just doesn't let me open two sound sources at
the same time. (the second app freezes without any messages)
> mm4 must include ALSA 1.0.1, so i don't know of this problem until
> now.
>=20
Haven't tried yet with -mm4, I'll do it when I get time to do it.
and the problem have been there for a long time, tested first time on
test2, didn't work then either.

Kind regards,
Markus.
--=20
"Software is like sex, it's better when it's free."
Markus H=E4stbacka <midian at ihme dot org>

--=-kuWmNYV5+ZkQ6HyzoE4z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBADTho3+NhIWS1JHARAherAJ99Bx5CkgggzyOGJrc0jzaqn4Ji8QCgySch
wuuxQUHSbEeYuhKtdBJVvHo=
=TUEm
-----END PGP SIGNATURE-----

--=-kuWmNYV5+ZkQ6HyzoE4z--

