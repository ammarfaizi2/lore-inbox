Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTI1ScE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTI1ScD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:32:03 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:8136 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262667AbTI1Sb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:31:59 -0400
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] [2.6.0-test6] Stale NFS file handle
Date: Sun, 28 Sep 2003 20:30:50 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Zkyd/tFDzabqonW";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309282031.54043.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Zkyd/tFDzabqonW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi,
since 2.6.0-test6 I get "Stale NFS file handle" when transferring huge amou=
nts=20
of data from a nfs-server which is running on -test6.
The client also runs -test6. Transfers from a server running kernel 2.4.22=
=20
work flawless.

I use the nfs-kernel-server 1.0.6 on Debian/sid.

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------




--Boundary-02=_Zkyd/tFDzabqonW
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/dykZ4q3E2oMjYtURAifTAJ0erJRSnLA0OYEFefqGIRSPdJruGwCbBIHr
J24NEaZt7x/cQkSqZmXqRVM=
=ApKz
-----END PGP SIGNATURE-----

--Boundary-02=_Zkyd/tFDzabqonW--

