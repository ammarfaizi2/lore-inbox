Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWEZOhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWEZOhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWEZOhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:37:21 -0400
Received: from lug-owl.de ([195.71.106.12]:19610 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750827AbWEZOhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:37:19 -0400
Date: Fri, 26 May 2006 16:37:18 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060526143718.GY13513@lug-owl.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <e55715+usls@eGroups.com> <447622EA.90704@garzik.org> <20060525213952.GT13513@lug-owl.de> <20060525214413.GE4328@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RGnAp+RkZMffi58C"
Content-Disposition: inline
In-Reply-To: <20060525214413.GE4328@redhat.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RGnAp+RkZMffi58C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 17:44:13 -0400, Dave Jones <davej@redhat.com> wrote:
> On Thu, May 25, 2006 at 11:39:52PM +0200, Jan-Benedict Glaw wrote:
>  > On Thu, 2006-05-25 17:34:34 -0400, Jeff Garzik <jeff@garzik.org> wrote:
>  > >=20
>  > > find / -name libata-scsi.c
>  >=20
>  > Which of the 10 versions showing up is the "right" one?
>=20
> For the sake of compiling out-of-tree modules, it's also useless,
> as sanitised headers (like Fedora's kernel-devel package) won't have this.
>=20
> Following /lib/modules/`uname -r`/build is the only way this can work.
> (And that should be true on any distro)

As long as you actually compile the modules on the machine they're
ment to run on...

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

--RGnAp+RkZMffi58C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEdxKeHb1edYOZ4bsRArOiAJ99Xzr8g5+wpilknq8JWWe/0kwaIgCfe2vA
/aTUMF6VzwZas5OgFSFrxyo=
=hRD1
-----END PGP SIGNATURE-----

--RGnAp+RkZMffi58C--
