Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUAIPUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAIPUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:20:33 -0500
Received: from [68.114.43.143] ([68.114.43.143]:26068 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S261868AbUAIPUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:20:20 -0500
Date: Fri, 9 Jan 2004 10:20:16 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Valdis.Kletnieks@vt.edu
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What SCSI in the IBM?
Message-ID: <20040109152016.GH24295@rdlg.net>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20040109150512.GF24295@rdlg.net> <200401091515.i09FFSDM030918@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Content-Disposition: inline
In-Reply-To: <200401091515.i09FFSDM030918@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thus spake Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):

> On Fri, 09 Jan 2004 10:05:12 EST, "Robert L. Harris" <Robert.L.Harris@rdl=
g.net>  said:
>=20
> > The network cards in this IBM came up great once I found the right port.
> > Now though I'm trying to find what SCSI driver to use.=20
>=20
> What IBM?  Laptop? PC? Netfinity? RS6K? e/i/p/z-series?

Ok, I found the "isa-pnp" module which fixed the unresolved module but
now the sym driver also just give no device errors.  This is a 2U Xeon
"eServer" model number x345.


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//saw8+1vMONE2jsRApWvAJ9m2aXR07cnWbhSxM7a1WEllagi/gCfcdfn
jPdGKiT8VeuPRZSlpbQElog=
=1+6a
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--
