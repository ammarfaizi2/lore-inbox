Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUE0Dsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUE0Dsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 23:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUE0Dsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 23:48:38 -0400
Received: from hostmaster.org ([212.186.110.32]:42886 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S261169AbUE0Dsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 23:48:36 -0400
Subject: CONFIG_IRQBALANCE for AMD64?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b2njUL8/NVbOo+m+Z1u6"
Message-Id: <1085629714.6583.12.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 05:48:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b2njUL8/NVbOo+m+Z1u6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I wonder why there is no in-kernel irq balancing for the AMD64
architecture yet. I guess this shouldn't be much different to the i386
code. Someone willing to explain/provide a patch?

Tom
--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Windows 98 supports real multitasking - it can boot and crash simultaneousl=
y.

--=-b2njUL8/NVbOo+m+Z1u6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQLVlEmD1OYqW/8uJAQLc7wf/aJMr+5p3fmDplri3PfXVamTmUzYNjSPG
/NOVJG6wyyFtqoogWTJZIWuNVZHCJfhc+UVqRBkYVORgl7weLTFJ8cYugGh1TLu7
2ilFSJTgL5hmu/GispyGGWBJKnsFxiaQckm64zCMTZEYmPI4bpvD1x9MN7pv7OFk
QSV7ZDDM4VnN+5f1ZJtg/Hdq4k2Ze+DeNDEenOS4X0Y5GpJ6kc+fXI4pGvYhKAtf
SA1ocoLVxFX2j1hL+fCUqaXZjCwtUcE82Ln+IsnDLxrAsghvtQUyiILbxduwfALi
5yu7LO4oNyJi/xbo395Jf/yLF3yYxrkwSHWtwNkKIycS5czst0yXag==
=fY0l
-----END PGP SIGNATURE-----

--=-b2njUL8/NVbOo+m+Z1u6--

