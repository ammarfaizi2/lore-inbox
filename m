Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbSJMDXI>; Sat, 12 Oct 2002 23:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSJMDXI>; Sat, 12 Oct 2002 23:23:08 -0400
Received: from [218.245.208.194] ([218.245.208.194]:10624 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261413AbSJMDW2>;
	Sat, 12 Oct 2002 23:22:28 -0400
Date: Sun, 13 Oct 2002 11:20:52 +0800
From: Hu Gang <hugang@soulinfo.com>
To: linux-kernel@vger.kernel.org
Subject: problem: suspend.
Message-Id: <20021013112052.3e767835.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.ieabJ8rHa(Uvp3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ieabJ8rHa(Uvp3
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__13_Oct_2002_11:20:52_+0800_0b8cd3e0"


--Multipart_Sun__13_Oct_2002_11:20:52_+0800_0b8cd3e0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

The software suspend in 2.5.42 can works , But have an problem I found.
An clean system can suspend and resume fine, But when do suspend again, the system can resume but will oops. it in BUG@tcascade@imer.c 309 line. Please help me.

thanks.

-- 
		- Hu Gang



--Multipart_Sun__13_Oct_2002_11:20:52_+0800_0b8cd3e0
Content-Type: text/plain;
 name="00000009.mimetmp"
Content-Disposition: attachment;
 filename="00000009.mimetmp"
Content-Transfer-Encoding: 7bit

Hello Pavel Machek:

The software suspend in 2.5.42 can works , But have an problem I found.
An clean system can suspend and resume fine, But when do suspend again, the system can resume but will oops. it in BUG@tcascade@imer.c 309 line. Please help me.

thanks.

-- 
		- Hu Gang



--Multipart_Sun__13_Oct_2002_11:20:52_+0800_0b8cd3e0
Content-Type: application/pgp-signature;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi4wIChHTlUv
TGludXgpCgppRDhEQlFFOXFEeVBQTTR1Q3k3YkFKZ1JBc3hIQUo0azRLb1VKN1FEMFBDU3FaY2U3
cE9ac2VCUnFBQ2VLdkpmCitWYlM4T3lHNE01azVISDllaEJsMlFnPQo9ZWlBQwotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KDQo=

--Multipart_Sun__13_Oct_2002_11:20:52_+0800_0b8cd3e0--

--=.ieabJ8rHa(Uvp3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qOaVPM4uCy7bAJgRAnbgAJ9mX+Un7clxoqDq/oag98lLdxXCOACdHuk6
A/ua+JV0zatPhIQmLwtNCqc=
=f91K
-----END PGP SIGNATURE-----

--=.ieabJ8rHa(Uvp3--
