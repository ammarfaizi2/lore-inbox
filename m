Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUADD6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUADD6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:58:06 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:28036 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265102AbUADD5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:57:50 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Sat, 3 Jan 2004 22:57:49 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1, scanner.ko, oops
Message-ID: <20040104035748.GA30429@butterfly.hjsoft.com>
References: <20040103183501.GA2906@butterfly.hjsoft.com> <20040103225154.GK11061@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20040103225154.GK11061@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2004 at 02:51:54PM -0800, Greg KH wrote:
> On Sat, Jan 03, 2004 at 01:35:01PM -0500, John M Flinchbaugh wrote:
> > i tried my canoscan 670u scanner with 2.6.1-rc1's scanner module,
> > xsane 0.91, sane 1.0.13.  (also, i'm using ohci-hcd on a tyan
> > thunder s2462ung.)
> Can you try not using the scanner module?  xsane should work just fine
> using libusb, talking to the device from userspace with no kernel
> module.

it does indeed work using libusb.  i had gotten the impression
that the scanner module may not be the preferred path these
days.  is this correct?
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/9488CGPRljI8080RArWEAKCKm7GJYGEXh71kuMUfXtJjS9k0IgCdFMj4
AcSfJEXuY2HWZMtABFomAPw=
=x5Cf
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
