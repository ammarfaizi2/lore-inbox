Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUBNQe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUBNQe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:34:28 -0500
Received: from darwin.snarc.org ([81.56.210.228]:51641 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S262328AbUBNQe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:34:26 -0500
Date: Sat, 14 Feb 2004 17:34:19 +0100
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Colin <cwv@cwv.tor.istop.com>, linux-kernel@vger.kernel.org,
       gadgeteer@elegantinnovations.org
Subject: Re: Radeon 9600 PCI IDs
Message-ID: <20040214163419.GA7676@snarc.org>
References: <40299791.7070504@cwv.tor.istop.com> <20040214120820.GH1308@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20040214120820.GH1308@fs.tum.de>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2004 at 01:08:20PM +0100, Adrian Bunk wrote:
> On Tue, Feb 10, 2004 at 09:46:41PM -0500, Colin wrote:
>=20
> > How come the kernel doesn't have any of the IDs for any of the Radeon 9=
600=20
> > in the pci.ids file?
>=20
> There are entries for the Radeon RV350 in both 2.4.24 and 2.6.2 .

We don't have the same 2.6.2 then ;)
My radeon 9600 pro isn't referenced in drivers/pci/pci.ids, neither
in 2.6.3-rc2-bk4

ATI Technologies Inc: Unknown device 4150
ATI Technologies Inc: Unknown device 4170

The pci.ids file on pciids.sourceforge.net seems to have many entries for
RV350.

--=20
Tab

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALk4LzKe/MInoaQARAsAmAJ9Evf1lU4mxMkpzqzo3PNTe9DZu3gCcCO6p
3yz97BM8tayab6vkpGuPsRM=
=IAQc
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
