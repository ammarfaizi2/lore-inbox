Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTLVTMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLVTMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:12:22 -0500
Received: from hostmaster.org ([80.110.173.103]:30848 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S263861AbTLVTMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:12:16 -0500
Subject: SYM53C8XX_2 fails with nosmp parameter on 2.6.0 and 2.4.23
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SjnwzCupXgN1L84dQMJ4"
Message-Id: <1072120324.1386.19.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 20:12:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SjnwzCupXgN1L84dQMJ4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Passing the nosmp parameter to a kernel with the SMY53C8XX_2 SCSI driver
causes a kernel oops on 2.4.23 and prevents the driver from detecting
any SCSI devices on 2.6.0.

Tom

PS: I vote for the inclusion of the oops to floppy patch

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

Hi, I'm a tagline virus. Please add me to your signature and help me spread=
 :)

--=-SjnwzCupXgN1L84dQMJ4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAP+dB/mD1OYqW/8uJAQJSWwf/YsfPf225SAGcWwkY63KMOzTQGiR5XUVo
C6s3lXe56Eju4LUAZ0qxBrlpAfSU6agBZ/Kvr5QwvYqsSczGUyE/xZ5+ceJGiJKh
GEZy4sLszP20VlTZ+Rqxr/8cEzxQtg+SGVqULyuoW8i8Bvdz30qgXBkEPyJitVzI
q/A4LSWFwVq66oRptHhXKFQ9zPAkwbtth4zlIk70haGBVtc03yRf3Fbz+j5yepXE
PE9Kh2YyGJinPKM4UZUbIWR2z04rv1KQxVJ2BraMbWnVMhf8OGuxlExl7tK8HAEB
fL8BK+/91EKkXTjCCKiXkmhwJz+Bma45pYURkVL2G9OCzR5L3Q70kQ==
=31Y9
-----END PGP SIGNATURE-----

--=-SjnwzCupXgN1L84dQMJ4--

