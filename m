Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUFRJZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUFRJZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUFRJY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:24:58 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:719 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265055AbUFRJVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:21:23 -0400
Date: Fri, 18 Jun 2004 11:21:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] New set of input patches
Message-ID: <20040618092121.GX20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200406180344.46191.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f7YFB2GF2LRiGJPG"
Content-Disposition: inline
In-Reply-To: <200406180344.46191.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f7YFB2GF2LRiGJPG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 03:44:46 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <200406180344.46191.dtor_core@ameritech.net>:

> would have parents. But the core integration is done. Unfortunately I do
> not have 90% hardware to test my changes so there could be some problems,
> although I tried to compile everything I could.

Maybe I'll test at least my two babies (vsxxxaa and lkkbd) to work with
these patches. They're using normal serial ports (ISA + USB) with
inputattach, these should already have parents, right?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--f7YFB2GF2LRiGJPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0rQRHb1edYOZ4bsRAnXGAJ4uWkqd2If+G7RdfsziPOZUDsqL9QCfaO2n
z+ebH47bMAFIbKCZ9wbEVds=
=1rl9
-----END PGP SIGNATURE-----

--f7YFB2GF2LRiGJPG--
