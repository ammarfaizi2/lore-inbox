Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTGGOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTGGOy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 10:54:59 -0400
Received: from mailc.telia.com ([194.22.190.4]:47349 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S262254AbTGGOy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 10:54:58 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: 2.5.74-mm2 + nvidia (and others)
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VEN7Ie1toC77uQhxjRzf"
Organization: LANIL
Message-Id: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 07 Jul 2003 17:08:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VEN7Ie1toC77uQhxjRzf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, running fine with 2.5.74-mm2 but when I try to insert the nvidia
module (with patches from www.minion.de applied) it gives=20

nvidia: Unknown symbol pmd_offset

in dmesg. The vmware vmmon module gives the same error (the others wont
compile but thats a different story).

The nvidia module works fine under plain 2.5.74.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-VEN7Ie1toC77uQhxjRzf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CYzeyqbmAWw8VdkRAoiIAJ9C/PpUYLN0bCLCESykEUUyvUIL4ACghIms
33tbCFy/6YtWNFlnGL0a5TU=
=f1Ck
-----END PGP SIGNATURE-----

--=-VEN7Ie1toC77uQhxjRzf--

