Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTFTJtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 05:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFTJtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 05:49:14 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:52892 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262589AbTFTJtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 05:49:13 -0400
Date: Fri, 20 Jun 2003 14:03:09 +0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030620100309.GE786@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com> <20030619093632.A29602@flint.arm.linux.org.uk> <20030619234249.GA31392@neo.rr.com> <20030620065547.B7431@flint.arm.linux.org.uk> <20030620061020.GC786@pazke> <20030620081021.C7431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Content-Disposition: inline
In-Reply-To: <20030620081021.C7431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -11.7 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 171, 06 20, 2003 at 08:10:22AM +0100, Russell King wrote:
> On Fri, Jun 20, 2003 at 10:10:20AM +0400, Andrey Panin wrote:
> > It was me who added this crappy quirk.
>=20
> It helps when the people with the problems are reading the list. 8)
>
> > My ELine modem which identified itself "Rockwell 56K ACF II Fax+Data+Vo=
ice
> > Modem" was going mad when its IRQ was shared with any device. So I deci=
ded
> > to add this quirk.
>=20
> Can you remember any further details?  Eg, was it when sharing with other
> serial ports (and were these serial ports in use), or any thing else?

Modem IRQ4 (IIRC) wash shared with onboard serial port and in this configur=
ation
there were massive receive data losses on the modem.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8tvdby9O0+A2ZecRApp4AKCrbHjryKy61SahGDO5geg5MNjiyQCgydE4
e1KsLYCJHmXRTNNPQxokm34=
=T8le
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
