Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUD2DWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUD2DWI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUD2DWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:22:08 -0400
Received: from mailoff.mtu.edu ([141.219.70.111]:40683 "EHLO mailoff.mtu.edu")
	by vger.kernel.org with ESMTP id S263125AbUD2DV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:21:59 -0400
Date: Wed, 28 Apr 2004 23:21:52 -0400
From: Jon <jon787@tesla.resnet.mtu.edu>
To: whitehorse@mustika.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040429032151.GE17234@tesla.resnet.mtu.edu>
Reply-To: jadevree@mtu.edu
References: <S263020AbUD2DDO/20040429030314Z+1040@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <S263020AbUD2DDO/20040429030314Z+1040@vger.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2004 at 11:03:08PM -0400, whitehorse@mustika.net wrote:
> dear Sir,
>  I have a problem in compiling kernel 2.6.4 from kernel 2.4.19. I use
>  Debian woody. When I rebooting new kernel, some message occur such:
>  "modprobe: QM_MODULES: function not implemented"
>  and I can't load my modules when boot. I would like to waiting any one w=
ho
>  answer this. Please send to this mail. Thanks
>=20
>  Best regards,
>=20
>  Hafid
>  Indonesia
>=20
You need to install module-init-tools which is not in Debian Woody
A backport of it for x86 machines is here
http://www.backports.org/debian/dists/woody/module-init-tools/
--=20
Jon
http://tesla.resnet.mtu.edu
The only meaning in life is the meaning you create for it.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkHTPrd+yBMYSKYIRAnMuAJ9RM36TGWQvUVGQ2/9sx3jLii6GvQCgnpsJ
2+v7u5UhboHb5WzilcMbmL8=
=G7xs
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

