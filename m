Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264191AbUEXJBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbUEXJBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 05:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUEXJAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 05:00:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47017 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264191AbUEXI5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:57:42 -0400
Date: Mon, 24 May 2004 04:57:27 -0400
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: Re: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
Message-ID: <20040524085727.GR3330@ruslug.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
References: <20040524083003.GA3330@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NfRCDefLLAVdwZEC"
Content-Disposition: inline
In-Reply-To: <20040524083003.GA3330@ruslug.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NfRCDefLLAVdwZEC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


BTW we can supply a 2.4 prism54 patch (as new driver). Would that be
wanted?

	Luis

On Mon, May 24, 2004 at 04:30:03AM -0400, Luis R. Rodriguez wrote:
>=20
> Jeff,
>=20
> Please apply the following patches to linux-2.6.7-rc1. These patches
> bring the kernel tree up to sync with prism54.org's 1.2's release.
>=20
> [PATCH 1/14 linux-2.6.7-rc1] prism54: add new private ioctls
> [PATCH 2/14 linux-2.6.7-rc1] prism54: reset card on tx_timeout
> [PATCH 3/14 linux-2.6.7-rc1] prism54: add iwspy support
> [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in monit=
or mode
> [PATCH 5/14 linux-2.6.7-rc1] prism54: new prism54 kernel compatibility
> [PATCH 6/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 74, 75
> [PATCH 7/14 linux-2.6.7-rc1] prism54: Fix 2.4 build
> [PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73
> [PATCH 9/14 linux-2.6.7-rc1] prism54: Fix prism54.org bug 77; strengthene=
d oid transaction
> [PATCH 10/14 linux-2.6.7-rc1] prism54: Don't allow mib reads while unconf=
igured
> [PATCH 11/14 linux-2.6.7-rc1] prism54: Touched up kernel compatibility
> [PATCH 12/14 linux-2.6.7-rc1] prism54: Start using likely/unlikely
> [PATCH 13/14 linux-2.6.7-rc1] prism54: Fix 2.4 SMP build
> [PATCH 14/14 linux-2.6.7-rc1] prism54: Fix channel stats; bump to 1.2
>=20
> 	Luis
> =09
> --=20
> GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 5=
25E



--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--NfRCDefLLAVdwZEC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbj3at1JN+IKUl4RAuuGAKCwQiOtqIxYMo+rXbmoLlb+ijsJ0ACeOCAH
RZ24iXAXvJ8ch413We2BgJg=
=MN82
-----END PGP SIGNATURE-----

--NfRCDefLLAVdwZEC--
