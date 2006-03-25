Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWCYI0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWCYI0R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 03:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWCYI0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 03:26:17 -0500
Received: from mx1.mm.pl ([217.172.224.151]:40412 "EHLO mx1.mm.pl")
	by vger.kernel.org with ESMTP id S1750769AbWCYI0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 03:26:16 -0500
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
To: ck@vds.kolivas.org
Subject: Re: [ck] [benchmark] Interbench 2.6.16-ck/mm
Date: Sat, 25 Mar 2006 09:21:26 +0100
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>,
       "=?utf-8?q?Andr=C3=A9_Goddard?= Rosa" <andre.goddard@gmail.com>,
       linux list <linux-kernel@vger.kernel.org>
References: <200603251351.57341.kernel@kolivas.org> <b8bf37780603241919x52e5711bpee734d3d9ec11cb9@mail.gmail.com> <200603251501.32592.kernel@kolivas.org>
In-Reply-To: <200603251501.32592.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1487275.9oiC8JZj6n";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603250921.32409.astralstorm@gorzow.mm.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1487275.9oiC8JZj6n
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 25 March 2006 05:01, Con Kolivas wrote yet:
>
> I don't expect that staircase will be better in every single situation.
> However it will be better more often, especially when it counts (like aud=
io
> or video skipping) and far more predictable. All that in 300 lines less
> code :)
>

I thinks the main difference is those other scheduler improvements.
Some of them are compatible with staircase.
Could you also try a mixed and matched 2.6.16-ck1+mm?

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1487275.9oiC8JZj6n
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEJP2MlUMEU9HxC6IRAjYYAJ0XcOWRTH11lMn2171uqnKAL9Q57wCeIFeb
dBl7SqfC7WlwYKCHWvmKpWA=
=Nw37
-----END PGP SIGNATURE-----

--nextPart1487275.9oiC8JZj6n--
