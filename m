Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVCWBkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVCWBkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCWBkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:40:35 -0500
Received: from a81-84-28-249.netcabo.pt ([81.84.28.249]:11146 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S262692AbVCWBk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:40:29 -0500
Subject: Starting input devices
From: Carlos Silva <r3pek@r3pek.homelinux.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DXmpPo4sDzTmtP09fHkI"
Date: Wed, 23 Mar 2005 01:40:09 +0000
Message-Id: <1111542009.12157.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DXmpPo4sDzTmtP09fHkI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi guys,

i'm trying to find somethin in the kernel tree and i can't :(
I want to know, where are the input devices (say mice and keyb) are
initialized. Where does the kernel search the bus for this devices?

basically, what does he do to print this messages:

input: AT Translated Set 2 keyboard on isa0060/serio0
input: SynPS/2 Synaptics TouchPad on isa0060/serio1

i'm just trying to track down what i think it's a problem.


Thanks,
Carlos Silva

--=-DXmpPo4sDzTmtP09fHkI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQMj5ttk+BQds59QRAj4dAKCFEx9GFx6XiLFGy5YrpgrHZLArKQCfWrTt
u5WcXBn7Yhpnrd6oU0hhQBI=
=CHXe
-----END PGP SIGNATURE-----

--=-DXmpPo4sDzTmtP09fHkI--

