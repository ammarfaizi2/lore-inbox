Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDUOQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTDUOQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:16:07 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:59410 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261300AbTDUOQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:16:06 -0400
Date: Mon, 21 Apr 2003 16:28:05 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Keeping the overview
Message-ID: <20030421142805.GU19139@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030421141643.GA1054@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pq8tEKHpn00JYbZk"
Content-Disposition: inline
In-Reply-To: <20030421141643.GA1054@neon.pearbough.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pq8tEKHpn00JYbZk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-21 16:16:43 +0200, Axel Siebenwirth <axel@pearbough.net>
wrote in message <20030421141643.GA1054@neon.pearbough.net>:
> Hi,
>=20
> i was just wondering what all you kernel developers do to keep an overview
> over this mass of source code.

Well, not everybody is interested in all code (but only in some
interesting fragment) so one knows that part. Others do need a full
overview over complete sources - these simply know the sources like
their spoken language's vocabulary. See - it's not looking at sources
for some weeks. It's looking at them for five or ten years.

> Are there any special tools or development GUIs for the kernel?

ctags may help, as well as LXR (to grovide a hint for non-expert
googlers: http://lxr.linux.no/ ).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--Pq8tEKHpn00JYbZk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+o//1Hb1edYOZ4bsRAreCAKCAA8c8LWvB7/vF9Xdtetvs07PJqQCfam5+
bxVJlyx/f2KybPg0WTv0USk=
=EZw4
-----END PGP SIGNATURE-----

--Pq8tEKHpn00JYbZk--
