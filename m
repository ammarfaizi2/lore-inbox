Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTH0Nwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTH0Nwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:52:42 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:63735 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262989AbTH0Nwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:52:40 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Wed, 27 Aug 2003 09:52:38 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 apm suspend just stops
Message-ID: <20030827135238.GA32743@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i followed the workaround presented in
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106191212815398&w=3D2
to get the ide cd to not oops my suspend.

now, i can watch it suspend the disks, listen to them spin down, and
then it just sits there, quietly, with the power led and screen on
(with display, not just backlight).

this is a dell inspiron, and i'm using the fn-suspend hotkey as works
nicely in 2.4.

thanks.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/TLemCGPRljI8080RAtdAAJ9qehBJ9KV3oojow4V9I4B5LEqlPACeMlhS
ZDpHg7rdetAwMe0UxyxJ750=
=li2v
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
