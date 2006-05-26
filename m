Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWEZSBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWEZSBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWEZSBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:01:33 -0400
Received: from lug-owl.de ([195.71.106.12]:31121 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751222AbWEZSBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:01:32 -0400
Date: Fri, 26 May 2006 20:01:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, drepper@redhat.com,
       akpm <akpm@osdl.org>, serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com,
       dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
Message-ID: <20060526180131.GA13513@lug-owl.de>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>, drepper@redhat.com,
	akpm <akpm@osdl.org>, serue@us.ibm.com, sam@vilain.net,
	clg@fr.ibm.com, dev@sw.ru
References: <20060525204534.4068e730.rdunlap@xenotime.net> <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de> <Pine.LNX.4.58.0605261025230.9655@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WxezjuMNsgvRf6mf"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605261025230.9655@shark.he.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WxezjuMNsgvRf6mf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 10:28:13 -0700, Randy.Dunlap <rdunlap@xenotime.net> wrot=
e:
> On Fri, 26 May 2006, Jan-Benedict Glaw wrote:
[Patch touchin all archs]
> > ...and this should have gone to linux-arch, too...
>=20
> so how does someone know:
> (a) that this should have gone to linux-arch

Anything that modifies all architectures (eg. new system calls,
low-level MM changes, ...) should go to linux-arch. This is where all
architecture maintainers are expected to be around.

> (b) that linux-arch exists

Noticing the existance of linux-arch is admittedly a hard job. It's a
quite specialized low-volume list, so most people actually never ever
recognize it--unfortunately.

> (c) what it's full email address it?

The list's email address is linux-arch@vger.kernel.org

> I.e., where is all of this explained?

Nowhere :-/

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

--WxezjuMNsgvRf6mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEd0J6Hb1edYOZ4bsRAmarAJ9KJHmDplZEdRrRxzm4x4S1goc/cACfX6GQ
9HvxJKyfRWDAxY/Scy7FN+I=
=7rUh
-----END PGP SIGNATURE-----

--WxezjuMNsgvRf6mf--
