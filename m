Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWBFT41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWBFT41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBFT41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:56:27 -0500
Received: from lug-owl.de ([195.71.106.12]:27341 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932342AbWBFT40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:56:26 -0500
Date: Mon, 6 Feb 2006 20:56:24 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Martin Mares <mj@ucw.cz>
Cc: Yaroslav Rastrigin <yarick@it-territory.ru>,
       Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       David Chow <davidchow@shaolinmicro.com>
Subject: Re: Linux drivers management
Message-ID: <20060206195624.GJ19232@lug-owl.de>
Mail-Followup-To: Martin Mares <mj@ucw.cz>,
	Yaroslav Rastrigin <yarick@it-territory.ru>,
	Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
	Nicolas Mailhot <nicolas.mailhot@laposte.net>,
	David Chow <davidchow@shaolinmicro.com>
References: <1139250712.20009.20.camel@rousalka.dyndns.org> <200602061002.27477.joshua.kugler@uaf.edu> <200602062217.19697.yarick@it-territory.ru> <mj+md-20060206.193433.6964.atrey@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <mj+md-20060206.193433.6964.atrey@ucw.cz>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-06 20:39:37 +0100, Martin Mares <mj@ucw.cz> wrote:
> > And then think, why do you need to _build_ drivers in the first place.
> > Wouldn't it be better to have one vmware.ko which insmod's with all
> > 2.6 versions , from 2.6.0 to 2.6.16-rc2 , and throw "upgrade pain"
> > away completely ?=20
>=20
> Well, you want the vmware.ko to contain machine code for at least 17
> different architecture the kernel runs on? ;-)

I think we will first need to hack binutils. The last time I heared
about it, Fat Binaries weren't implemented (only containing object
code for two different architectures), let alone for _all_
architectures...

Even getting all GCCs to compile with the same version would be an
adventure...

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

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD56noHb1edYOZ4bsRAo8uAKCK0igW4Hzii+IV3MtP6CsY8034CQCbBUZ/
od75dbj9hAaWzlY+vin5kg8=
=Vps+
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
