Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTKMWoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTKMWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:44:23 -0500
Received: from dd1234.kasserver.com ([81.209.148.157]:21726 "EHLO
	dd1234.kasserver.com") by vger.kernel.org with ESMTP
	id S264447AbTKMWoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:44:21 -0500
Date: Thu, 13 Nov 2003 22:44:10 +0000
From: Jochen Voss <voss@seehuhn.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: invalid SMP mptable on Toshiba Satellite 2430-301
Message-ID: <20031113224410.GA7852@seehuhn.de>
References: <20031113193043.GA1366@seehuhn.de> <Pine.LNX.4.44.0311131408250.1861-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311131408250.1861-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 13, 2003 at 02:21:12PM -0800, Linus Torvalds wrote:
> ..., which would
> imply that your BIOS tables really _are_ UP-only, even for ACPI.
>=20
> Did they actually sell you the thing as being HT-enabled? It doesn't look=
=20
> like it is..
No, they did not even mention HT.  Which, I guess now,
stands for "HT will not work".  I just wanted to try it.

I think the best thing would be, to incorporate the patch to
prevent the crashes with "local APIC support on
uniprocessors" enabled and ignore the rest of the problem.

Thank you for your help,
Jochen
--=20
http://seehuhn.de/

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tAk6f+iD8yEbECURAr1/AJ9+HrfyW8jF6keIOw5pDMqDXfNSOwCghYbP
/Nr9WpMcB1+SNsgfGNF4qHQ=
=yCtl
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
