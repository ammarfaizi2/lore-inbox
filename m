Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWE1NNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWE1NNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 09:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWE1NNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 09:13:00 -0400
Received: from lug-owl.de ([195.71.106.12]:5041 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750759AbWE1NM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 09:12:59 -0400
Date: Sun, 28 May 2006 15:12:58 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060528131257.GN13513@lug-owl.de>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
	linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="owpTafYe/1tj88Rh"
Content-Disposition: inline
In-Reply-To: <20060528130320.GA10385@osiris.ibm.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--owpTafYe/1tj88Rh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-05-28 15:03:20 +0200, Heiko Carstens <heiko.carstens@de.ibm.co=
m> wrote:
> > > I'd really like to see a distro-agnostic way to retrieve the kernel
> > > configuration.  /proc/config.gz has existed for soem time but many
> > > distros inexplicably don't enable it.
> >=20
> > /boot/config-`uname -r`
>=20
> What's the reason for distros to disable /proc/config.gz?

To save memory?  The config can be placed as a plain file, so why
waste non-swappable kernel memory for a task that can easily be done
with a simple file?

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

--owpTafYe/1tj88Rh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEeaHZHb1edYOZ4bsRAmDoAJ9nPZBRlWL3OtlqUVEa6vHke4pKygCgjU5K
TtXjv/dXCYHICOj18t/JSYQ=
=4urW
-----END PGP SIGNATURE-----

--owpTafYe/1tj88Rh--
