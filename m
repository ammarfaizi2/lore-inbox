Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSLMQO3>; Fri, 13 Dec 2002 11:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSLMQO3>; Fri, 13 Dec 2002 11:14:29 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:54535 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S265093AbSLMQO2>;
	Fri, 13 Dec 2002 11:14:28 -0500
Date: Fri, 13 Dec 2002 17:22:17 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: michael@lug-owl.de
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Message-ID: <20021213162217.GP20409@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, michael@lug-owl.de
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de> <at2r5v$fib$1@cesium.transmeta.com> <20021210213444.GA451@elf.ucw.cz> <3DF7BF10.7030204@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ZRxqsK4bBEmgNeO"
Content-Disposition: inline
In-Reply-To: <3DF7BF10.7030204@zytor.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9ZRxqsK4bBEmgNeO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-12-11 14:41:20 -0800, H. Peter Anvin <hpa@zytor.com>
wrote in message <3DF7BF10.7030204@zytor.com>:
> Pavel Machek wrote:
> >=20
> > Well, nothing prevents keyboard manufacturers from using 0xe2 as a
> > prefix, too. I think there are really *weird* keyboards out there.
> >=20
>=20
> True enough, although very few things are going to recognize them at all.

A co-worker of me once developed some patch to handle some weired
Point of Sale keyboards (with magnetic stripe reader and some lock and
so on). He did it by allowing additional modules to parse everything
what is coming from keyboard controller (through additionally hooked
modules) before sending "normal" keycaps events to userspace. An
application willing to get the extra data could fetch that from some
/dev/ice node. This could be generalized to send input API events. I'll
CC him to allow him to speak up.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--9ZRxqsK4bBEmgNeO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9+gk5Hb1edYOZ4bsRAv4RAKCP8cT3CD8HOHnTUFjTKzmjFwktswCfRAhF
fxmQeyYu+KeYc0vXtbvLsYM=
=omLE
-----END PGP SIGNATURE-----

--9ZRxqsK4bBEmgNeO--
