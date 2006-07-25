Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWGYNxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGYNxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 09:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWGYNxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 09:53:06 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:16586 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932126AbWGYNxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 09:53:05 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Where does kernel/resource.c.1 file come from?
Date: Tue, 25 Jul 2006 15:54:45 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1276482.usPy7boNxZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607251554.50484.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1276482.usPy7boNxZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm playing around with my local copy of linux-2.6 git tree. I'm building=20
everything to a separate directory using O=3D to keep "git status" silent.

After building I sometimes find a file kernel/resource.c.1 in my git tree t=
hat=20
doesn't really belong there. Who is generating this file, for what reason a=
nd=20
why doesn't it get created in my output directory?

Eike

--nextPart1276482.usPy7boNxZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBExiKqXKSJPmm5/E4RAv9sAKClgviOMLOn8kjygWYzLmfaJwvOSwCdFAjX
j3scHgDgeuKbg7Eeh+P60NA=
=hIQI
-----END PGP SIGNATURE-----

--nextPart1276482.usPy7boNxZ--
