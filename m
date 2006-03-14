Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWCNKuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWCNKuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWCNKuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:50:09 -0500
Received: from lug-owl.de ([195.71.106.12]:2988 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932314AbWCNKuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:50:07 -0500
Date: Tue, 14 Mar 2006 11:50:05 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
       promise_linux@promise.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
Message-ID: <20060314105005.GD32065@lug-owl.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
	promise_linux@promise.com, linux-kernel@vger.kernel.org
References: <20060313224112.GA19513@havoc.gtf.org> <20060313154236.32293cf9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <20060313154236.32293cf9.akpm@osdl.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-13 15:42:36 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
> > +config SCSI_SHASTA
> > +	tristate "Promise SuperTrek EX8350/8300/16350/16300 support"
> > +	depends on PCI && SCSI
>=20
> Might it also depend upon BLK_DEV_SD?

Or SELECTS?

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

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEFp/dHb1edYOZ4bsRAh+NAJsFbfSMfWqWtPd2EZ8Cz7CIEa1gwgCeOEbx
XrKrsAMsHLmbjR1C2C+35wI=
=5puI
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
