Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754336AbWKHGDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbWKHGDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 01:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbWKHGDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 01:03:30 -0500
Received: from lug-owl.de ([195.71.106.12]:46263 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1753127AbWKHGD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 01:03:29 -0500
Date: Wed, 8 Nov 2006 07:03:28 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: eki@sci.fi, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Missing *eof assignment in Alpha's srm_env driver
Message-ID: <20061108060328.GA21485@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>, eki@sci.fi,
	linux-kernel@vger.kernel.org
References: <20061107230201.GY21485@lug-owl.de> <Pine.LNX.4.64.0611071522050.3667@g5.osdl.org> <20061107232546.GZ21485@lug-owl.de> <Pine.LNX.4.64.0611071822360.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SBYWXwvsCkEY5LOm"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071822360.3667@g5.osdl.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SBYWXwvsCkEY5LOm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-07 18:23:26 -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 8 Nov 2006, Jan-Benedict Glaw wrote:
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/jbglaw/vax-linux.git fixe=
s_for_linus
>=20
> Your kernel.org repo is _really_ slow. Have you repacked it and otherwise=
=20
> maintained it? Or maybe it's just kernel.org being slow right now.

Packed and using your repo for alternates:

jbglaw@hera:/pub/scm/linux/kernel/git/jbglaw$ du -ms vax-linux.git/
8       vax-linux.git/

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
  Signature of:                           Wenn ich wach bin, tr=C3=A4ume ic=
h.
  the second  :

--SBYWXwvsCkEY5LOm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFUXMwHb1edYOZ4bsRAl88AJ0cMSWyyP5Sbwefk37uWorJp1Pr6gCeNfad
/WV8QGp+W/fHuyGCRNnA9tw=
=zpxT
-----END PGP SIGNATURE-----

--SBYWXwvsCkEY5LOm--
