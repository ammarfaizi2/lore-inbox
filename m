Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUFXHDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUFXHDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 03:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXHDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 03:03:31 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:38092 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262434AbUFXHD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 03:03:28 -0400
Date: Thu, 24 Jun 2004 08:55:01 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: jsimmons@pentafluge.infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
Message-ID: <20040624065501.GD13436@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix> <20040620192549.GA4307@bogon.ms20.nix> <Pine.LNX.4.56.0406232035340.27210@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406232035340.27210@pentafluge.infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2004 at 08:35:56PM +0100, jsimmons@pentafluge.infradead.org=
 wrote:
>=20
> Could you compare it to my latest Nvidia driver?=20
You applied a patch I sent to you that removes this array and determines
the NV_TYPE by PCI ID about 5 months ago, so there's no need for this
fix in you tree.
Cheers,
 -- Guido

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2nrFn88szT8+ZCYRAqTOAJ9MoMKCZ7kwY/IQSWU/LpO3KDNUMACffY40
8jBXUg04BYJFxrlYe37qsu8=
=jcci
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
