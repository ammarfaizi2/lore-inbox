Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbTGHPhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267479AbTGHPhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:37:11 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2053 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267451AbTGHPgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:36:54 -0400
Date: Tue, 8 Jul 2003 17:51:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys gpl code [OT]
Message-ID: <20030708155129.GL20605@lug-owl.de>
Mail-Followup-To: Kernel <linux-kernel@vger.kernel.org>
References: <JGJMIEHJHFNACGAA@mailcity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline
In-Reply-To: <JGJMIEHJHFNACGAA@mailcity.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-08 22:40:53 +0700, Tace   <tace@lycos.com>
wrote in message <JGJMIEHJHFNACGAA@mailcity.com>:
> Hi,
>   does anyone know what kind of assembly code the linksys gpl code compil=
es to? i.e. ARM?

It's mips - see the patch for ./linux/Makefile .

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/CuiBHb1edYOZ4bsRAhz7AJ9U4ytwHMt0HjNYEeMMpnjhxit7ngCfXOIU
AncbI1LcMJWSeFFSEAMtDsA=
=xXWh
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--
