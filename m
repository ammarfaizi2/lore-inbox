Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpQUioBqJMucQRaSiFHlMpbFq9w==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Message-ID: <04a701c415a5$05220800$d100000a@sbs2003.local>
Delivery-date: Tue, 06 Jan 2004 08:26:08 +0000
Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:46:37 +0100
From: "Jean-Marc Valin" <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
In-Reply-To: <1073370806.2687.18.camel@mentor.gurulabs.com>
To: <Administrator@osdl.org>
Cc: <Valdis.Kletnieks@vt.edu>, "Andrew Morton" <akpm@osdl.org>,
        "Yu, Luming" <luming.yu@intel.com>,
        "Linux Kernel" <linux-kernel@vger.kernel.org>, <linux-acpi@intel.com>
Organization: =?iso-8859-1?Q?Universit=C3=A9_de_Sherbrooke?=
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jg+bYjuNul9oAetcObKt"
References: <1073354003.4101.11.camel@idefix.homelinux.org> <20040105180859.7e20e87a.akpm@osdl.org> <200401060259.i062xrb3002240@turing-police.cc.vt.edu> <1073370806.2687.18.camel@mentor.gurulabs.com>
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:46:37.0390 (UTC) FILETIME=[052DEEE0:01C415A5]

This is a multi-part message in MIME format.

--=-jg+bYjuNul9oAetcObKt
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > As suggested by Yu Luming, the patch at http://bugzilla.kernel.org/show=
_bug.cgi?id=3D1766
> > is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives me:
>=20
> Just confirming that the same patched fixed up the battery reporting
> problems on my laptop as well.

Works for me too. Case closed?

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-jg+bYjuNul9oAetcObKt
Content-Transfer-Encoding: 7bit
Content-Type: application/pgp-signature;
	name="signature.asc"
Content-Description: =?iso-8859-1?Q?Ceci_est_une_partie_de_messagenum=E9riquement_sign=E9e.?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/+nBwdXwABdFiRMQRArUuAKCxPhzvzSMEDy0g4BqpwScFcGarTACggfsW
a2FnjjXMc4lFVok9ZEWvEcY=
=Uqsj
-----END PGP SIGNATURE-----

--=-jg+bYjuNul9oAetcObKt--
