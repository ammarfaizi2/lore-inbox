Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTDVFsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 01:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTDVFsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 01:48:19 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38405 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262945AbTDVFsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 01:48:18 -0400
Date: Tue, 22 Apr 2003 08:00:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68{,-bk1,-bk2} refuses to boot
Message-ID: <20030422060021.GA19139@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304221526400.29695-100000@bad-sports.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSfbCJd5UFatzzNC"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304221526400.29695-100000@bad-sports.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VSfbCJd5UFatzzNC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-04-22 15:31:13 +1000, Brett <generica@email.com>
wrote in message <Pine.LNX.4.44.0304221526400.29695-100000@bad-sports.com>:
>=20
> Hey,
>=20
> topic says it all
> blank screen after grub loads the kernel

You possibly forgot CONFIG_INPUT=3Dy and CONFIG_VT=3Dy or so...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--VSfbCJd5UFatzzNC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+pNp1Hb1edYOZ4bsRAunGAJinrWDR+HVf8G1PzXvdoiiZfLCBAJ9bzPv2
kQMA3n09MuIHBUK3Aj9hCw==
=aR7N
-----END PGP SIGNATURE-----

--VSfbCJd5UFatzzNC--
