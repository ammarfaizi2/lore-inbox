Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266100AbUFWGhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUFWGhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUFWGhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:37:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:55173 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266100AbUFWGhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:37:48 -0400
Date: Wed, 23 Jun 2004 02:37:37 -0400
To: prism54-devel@prism54.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>
Subject: Prism54 1.2 is out
Message-ID: <20040623063737.GW6253@ruslug.rutgers.edu>
Mail-Followup-To: prism54-devel@prism54.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netdev <netdev@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Quick notice to developers. Prism54 1.2 is out, cvs was tagged with
rel-1-2. The 2.6.7-bk3 and 2.6.7-mm1 have prism54 1.2. I just submitted
prism54 1.2 to Andrew for the 2.4 stock kernel.

Patches and development improvements are now welcomed but from now=20
on please submit any changes/patches for verification first
with netdev. If accepted then apply to CVS. We're no longer a cheap'ol
driver, our changes need to be reviewed by the good guys now ;)=20

If you're not subscribed to netdev and you are a prism54 developer,=20
please do so as prism54 development discussion should take place there now.
We'll still use prism54 devel for archiving purposes (CC's to netdev).

I've put some notes on the prism54.org page, if I forgot
something/someone I'm sorry, please e-mail me. I'll go ahead now and=20
null out the ChangeLog so we can start 1.3 work.=20

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2SUxat1JN+IKUl4RAtK2AJ9UXMNS5lNoxHwL1MQ+ruIGEOrbhgCgjO3g
B3nvESbxox3mH54FpxxtANw=
=7fzh
-----END PGP SIGNATURE-----

--XAEV7zm15O60d1Zf--
