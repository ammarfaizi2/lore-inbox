Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266279AbUFPNAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUFPNAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUFPM5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:57:31 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:27788 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266287AbUFPMzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:55:20 -0400
Subject: 2.6.7 warnings
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
Reply-To: TazForEver@free.fr
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hkbg+1W4Ls0ny0PFeUXb"
Date: Wed, 16 Jun 2004 14:55:17 +0200
Message-Id: <1087390517.22712.6.camel@athlon>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hkbg+1W4Ls0ny0PFeUXb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

drivers/video/fbmem.c: In function `fb_cursor':
drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user'
discards qualifiers from pointer target type

sound/pci/via82xx.c: In function `snd_via82xx_probe':
sound/pci/via82xx.c:2252: warning: statement with no effect
(cpp shows that this statement is reduced to -22;)

--=20
Beno=C3=AEt Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr

--=-Hkbg+1W4Ls0ny0PFeUXb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA0EM1liyxJIUSPQoRAv5qAJoDKtq92Z6CAhRU+KVBsv/d9gRmiwCff6rm
ABRZiM3sqc12GmUPBOBDpMk=
=VPIp
-----END PGP SIGNATURE-----

--=-Hkbg+1W4Ls0ny0PFeUXb--

