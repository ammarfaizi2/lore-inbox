Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVDAUbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVDAUbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbVDAUbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:31:19 -0500
Received: from lug-owl.de ([195.71.106.12]:30662 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262877AbVDAU1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:27:44 -0500
Date: Fri, 1 Apr 2005 22:27:43 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] clean up kernel messages
Message-ID: <20050401202743.GX21175@lug-owl.de>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050401200851.GG15453@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CYcXvPfqKSDi0QhV"
Content-Disposition: inline
In-Reply-To: <20050401200851.GG15453@waste.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CYcXvPfqKSDi0QhV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 12:08:51 -0800, Matt Mackall <mpm@selenic.com>
wrote in message <20050401200851.GG15453@waste.org>:
> This patch tidies up those annoying kernel messages. A typical kernel
> boot now looks like this:
>=20
> Loading Linux... Uncompressing kernel...
> #
>=20
> See? Much nicer. This patch saves about 375k on my laptop config and
> nearly 100k on minimal configs.

Please also notice these space-savings in the Kconfig help text.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--CYcXvPfqKSDi0QhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCTa6/Hb1edYOZ4bsRArE5AJ9P0bZp+7Miu6JHn0MM/gFCmkFTgwCeKBUE
oRGGEh5pgBTEcS8D3gsT+Uk=
=FFSa
-----END PGP SIGNATURE-----

--CYcXvPfqKSDi0QhV--
