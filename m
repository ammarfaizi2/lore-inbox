Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTKQH21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 02:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTKQH20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 02:28:26 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2519 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263369AbTKQH2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 02:28:23 -0500
Date: Mon, 17 Nov 2003 08:28:22 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
Message-ID: <20031117072822.GO26866@lug-owl.de>
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1068970562.19499.11.camel@thalience> <1069022225.19499.59.camel@thalience>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U0B5otXy6WXfork9"
Content-Disposition: inline
In-Reply-To: <1069022225.19499.59.camel@thalience>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U0B5otXy6WXfork9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-11-16 17:37:05 -0500, Will Dyson <will_dyson@pobox.com>
wrote in message <1069022225.19499.59.camel@thalience>:
> On Sun, 2003-11-16 at 03:16, Will Dyson wrote:

> -int match_token(char *s, match_table_t table, substring_t args[]);
> -
> +int match_token(char *, match_table_t table, substring_t args[]);

Dropping the blank line is okay, but I don't like dropping "s"
altogether:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--U0B5otXy6WXfork9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uHiVHb1edYOZ4bsRAjLUAKCLpUd89wj/bz4ESvs5GhmpxhPd8wCghJ3G
rcTKuTxzsZZJE1uYCwPRUKg=
=VPB3
-----END PGP SIGNATURE-----

--U0B5otXy6WXfork9--
