Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUEXIad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUEXIad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUEXIad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:30:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:11934 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264131AbUEXIaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:30:24 -0400
Date: Mon, 24 May 2004 04:30:03 -0400
From: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
Message-ID: <20040524083003.GA3330@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RGnAp+RkZMffi58C"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RGnAp+RkZMffi58C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Jeff,

Please apply the following patches to linux-2.6.7-rc1. These patches
bring the kernel tree up to sync with prism54.org's 1.2's release.

[PATCH 1/14 linux-2.6.7-rc1] prism54: add new private ioctls
[PATCH 2/14 linux-2.6.7-rc1] prism54: reset card on tx_timeout
[PATCH 3/14 linux-2.6.7-rc1] prism54: add iwspy support
[PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in monitor=
 mode
[PATCH 5/14 linux-2.6.7-rc1] prism54: new prism54 kernel compatibility
[PATCH 6/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 74, 75
[PATCH 7/14 linux-2.6.7-rc1] prism54: Fix 2.4 build
[PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73
[PATCH 9/14 linux-2.6.7-rc1] prism54: Fix prism54.org bug 77; strengthened =
oid transaction
[PATCH 10/14 linux-2.6.7-rc1] prism54: Don't allow mib reads while unconfig=
ured
[PATCH 11/14 linux-2.6.7-rc1] prism54: Touched up kernel compatibility
[PATCH 12/14 linux-2.6.7-rc1] prism54: Start using likely/unlikely
[PATCH 13/14 linux-2.6.7-rc1] prism54: Fix 2.4 SMP build
[PATCH 14/14 linux-2.6.7-rc1] prism54: Fix channel stats; bump to 1.2

	Luis
=09
--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--RGnAp+RkZMffi58C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsbKLat1JN+IKUl4RAopEAKCcfzcbKfe/oHHS2OSmTn1ZUH/9FwCgkWx7
VfqwWACzI0XT9byCLXuPG78=
=sF73
-----END PGP SIGNATURE-----

--RGnAp+RkZMffi58C--
