Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUE0TUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUE0TUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUE0TT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:19:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:65476 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265086AbUE0TRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:17:09 -0400
Date: Thu, 27 May 2004 15:16:49 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [Prism54-devel] Re: [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in
Message-ID: <20040527191649.GT3330@ruslug.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org
References: <20040524083146.GE3330@ruslug.rutgers.edu> <40B631B3.4000902@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYLBaaOo3Zs/tS0r"
Content-Disposition: inline
In-Reply-To: <40B631B3.4000902@pobox.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TYLBaaOo3Zs/tS0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2004 at 02:21:39PM -0400, Jeff Garzik wrote:
> Luis R. Rodriguez wrote:
> >diff -u -r1.31 -r1.33
> >--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 200=
4=20
> >15:27:44 -0000	1.31
> >+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	19 Mar 200=
4=20
> >23:03:58 -0000	1.33
> >@@ -1,4 +1,4 @@
> >-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03/1=
8=20
> >15:27:44 ajfa Exp $
> >+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/1=
9=20
> >23:03:58 ajfa Exp $
>=20
>=20
> Please remove CVS substitions from your code, they cause endless patch=20
> rejects if I choose to apply (for example) 10 out of 14 patches.

Will do. So if you get=20

--- ksrc/islpci_eth.c
+++ ksrc-new/islpci_eth.c

patches, that'll be OK? I substituted ksrc to
linux-2.6.7-rc1/drivers/net/wireless/prism54 thinking that'll ease your
job. Sorry for any inconvenience.

	Luis
--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--TYLBaaOo3Zs/tS0r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtj6hat1JN+IKUl4RAhXqAJ4xlthMjtIO6OPRalzWJwFW2eNXYACaA59Z
86IeyaE6d3bplSB04Z2UYpY=
=c7nD
-----END PGP SIGNATURE-----

--TYLBaaOo3Zs/tS0r--
