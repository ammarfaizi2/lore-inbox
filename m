Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTDHJWu (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbTDHJWj (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:22:39 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:60178 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261300AbTDHJVx (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 05:21:53 -0400
Date: Tue, 8 Apr 2003 11:33:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
Message-ID: <20030408093329.GT23095@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030407171037.GB8178@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pP8l8ytKVQui4K7o"
Content-Disposition: inline
In-Reply-To: <20030407171037.GB8178@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pP8l8ytKVQui4K7o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-04-07 19:10:37 +0200, J=F6rn Engel <joern@wohnheim.fh-wedel.de>
wrote in message <20030407171037.GB8178@wohnheim.fh-wedel.de>:
> Hi!
>=20
> Some days ago, I've started a -je [*] tree which will focus on memory
> reduction for the linux kernel.

If you can live with being blind, substiture printk with a macro (doing
nothing but eventually evaluating the parameters). That'll easily give
you another 100K or even more.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--pP8l8ytKVQui4K7o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kpdpHb1edYOZ4bsRAkJsAJ97fhu0mj03QSaxFVV9qenHibdSBQCffSNl
SomJJxRbi9hfuHTE9VDbp2o=
=USdV
-----END PGP SIGNATURE-----

--pP8l8ytKVQui4K7o--
