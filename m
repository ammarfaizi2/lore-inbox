Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWKENHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWKENHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWKENHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:07:35 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:20452 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932684AbWKENHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:07:34 -0500
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: linux-kernel@vger.kernel.org
Subject: [Opps] Invalid opcode
Date: Sun, 5 Nov 2006 15:07:36 +0200
User-Agent: KMail/1.9.5
Cc: Zachary Amsden <zach@vmware.com>, Gerd Hoffmann <kraxel@suse.de>,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13068103.hnilLZKrUh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611051507.37196.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13068103.hnilLZKrUh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

2.6.18, 2.6.18.1 and 2.6.18.2 still panics randomly (it seems this is not=20
related to smpreplacament bug solved in .2) in VmWare and Microsoft Virtual=
=20
PC and in order to confirm this bug is not our distro specific i downloaded=
=20
and tried latest OpenSuse also [1]  and [2] are screens captured by vmware=
=20
but exact same panic occurs in Virtual PC as reported to us in [3]. I CC'ed=
=20
previous threads receivers also.

[1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic.png
[2] http://cekirdek.pardus.org.tr/~caglar/2.6.18/panic.png
[3] http://bugs.pardus.org.tr/show_bug.cgi?id=3D3804

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart13068103.hnilLZKrUh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFTeIZy7E6i0LKo6YRAi5cAKC7uSg9ndu5dxaqdiPGB4a4LVl7IACgj01w
Rpkalt60p41psg9ifQM3niQ=
=ESUl
-----END PGP SIGNATURE-----

--nextPart13068103.hnilLZKrUh--
