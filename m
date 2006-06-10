Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWFJKvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWFJKvn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWFJKvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:51:43 -0400
Received: from lug-owl.de ([195.71.106.12]:14523 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751486AbWFJKvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:51:43 -0400
Date: Sat, 10 Jun 2006 12:51:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: smartmontools-support@lists.sourceforge.net,
       Remy Card <Remy.Card@linux.org>, "Theodore Ts'o" <tytso@alum.mit.edu>,
       David Beattie <dbeattie@softhome.net>, linux-kernel@vger.kernel.org,
       apiszcz@solarrain.com
Subject: Re: The Death and Diagnosis of a Dying Hard Drive - Is S.M.A.R.T. useful?
Message-ID: <20060610105141.GE30775@lug-owl.de>
Mail-Followup-To: Justin Piszcz <jpiszcz@lucidpixels.com>,
	smartmontools-support@lists.sourceforge.net,
	Remy Card <Remy.Card@linux.org>, Theodore Ts'o <tytso@alum.mit.edu>,
	David Beattie <dbeattie@softhome.net>, linux-kernel@vger.kernel.org,
	apiszcz@solarrain.com
References: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-06-10 06:23:32 -0400, Justin Piszcz <jpiszcz@lucidpixels.com> =
wrote:
> SUMMARY:
> I pose the following question in the subject, as over the years running=
=20
> smartd and having failed disks, I have always first been alerted of bad=
=20
> sectors and such through dmesg or logcheck.  Even with a bad disk I=20
> currently have, smartd does not pickup any errors, except those with the=
=20
> kernel writes to syslog.

What do

	smartctl -H
	smartctl --all

tell you?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEiqQ9Hb1edYOZ4bsRAi9AAJ9SjcQqdl7pOfVoi+qSfQ4oLk3sfQCfYsTx
TczeIlKFVgpFgRN6amCGvTQ=
=ucrF
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--
