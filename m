Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUEaW6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUEaW6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEaW6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:58:08 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:5904 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S263154AbUEaW6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:58:03 -0400
Date: Mon, 31 May 2004 19:57:44 -0300
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: misc device suspend/resume new model 
Message-ID: <20040531225744.GA6682@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
what is the preferred way of getting suspend/resume events (new model)
with misc devices registered via misc_register.

Registering a sys_driver/device/class ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu7hoUaz2rXW+gJcRAijnAJ9FeoiGoL6iO6+A8cCiEXQs34IJnACgid09
zf9uWV836/QncRAEEXvSJPM=
=SbB2
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
