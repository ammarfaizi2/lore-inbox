Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTK0NDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTK0NDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:03:01 -0500
Received: from stan.ping.de ([62.72.95.4]:63911 "EHLO stan.ping.de")
	by vger.kernel.org with ESMTP id S264511AbTK0NBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:01:31 -0500
X-IMAP-Sender: rene
Date: Thu, 27 Nov 2003 13:53:44 +0100
X-OfflineIMAP-x1320464056-52656d6f7465-494e424f582e4f7574626f78: 1069937677-0804292084135
From: Rene Engelhard <rene@rene-engelhard.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11: Mouse breaks after Suspend-to-RAM
Message-ID: <20031127125344.GA2606@rene-engelhard.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux
X-GnuPG-Key: $ finger rene@db.debian.org
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ please Cc: me as I am not on linux-kernel ]

Hi,

Suspend-to-Dsk via Software Suspend seems to work fine -- however,
Suspend-to-RAM doesn't.

When I echo 3 > /proc/acpi/sleep it goes into sleep mode as it should
and it awakes as it should. However, my mouse in X then is really
confused and does not do what I want it to do.

On the tthy then there is written:

psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization,
throwing 2 bytes away.

I need to reboot :/

This "mouse" is a trackpad if that helps..

If you need some more infos, mail me..

Gr=FC=DFe/Regards,

Ren=E9

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xfPX+FmQsCSK63MRAqKEAJ991YLmoJtPMLejFvQArfu5OR2NQQCfX7ax
Uex6ez9k5uhvQVEuJr1eT70=
=IelA
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
