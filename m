Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423782AbWKHVIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423782AbWKHVIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423784AbWKHVIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:08:16 -0500
Received: from lug-owl.de ([195.71.106.12]:14041 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1423782AbWKHVIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:08:15 -0500
Date: Wed, 8 Nov 2006 22:08:14 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to compile module params into kernel?
Message-ID: <20061108210813.GE21485@lug-owl.de>
Mail-Followup-To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	'Jesper Juhl' <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <02fd01c70370$d9af6700$020120ac@Jocke> <00fc01c70378$d1ffa760$0732700a@djlaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggCU0ZO/FnK1VHVi"
Content-Disposition: inline
In-Reply-To: <00fc01c70378$d1ffa760$0732700a@djlaptop>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ggCU0ZO/FnK1VHVi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 15:59:44 -0500, Richard B. Johnson <jmodem@AbominableFir=
ebug.com> wrote:
> If you don't have a module, you can not use module parameters. However, i=
t=20
> might even be simpler...

Well, you actually can!  If you've compiled something into your
kernel, you can use  <module name>.<parametername>=3D<value>  on your
kernel command line to set all the parameters you need.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                 Gib Dein Bestes. Dann =C3=BCbertriff Dich sel=
bst!
the second  :

--ggCU0ZO/FnK1VHVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFUkc9Hb1edYOZ4bsRAo7aAKCGn64mEGamvQXTrAUPo5bxhyzE7wCfaMRS
I/OPqYNWT0/cl03KFRZCKgw=
=MgGh
-----END PGP SIGNATURE-----

--ggCU0ZO/FnK1VHVi--
