Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbTG0R0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 13:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270874AbTG0R0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 13:26:10 -0400
Received: from NeverAgain.DE ([217.69.76.1]:25306 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S270870AbTG0R0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 13:26:08 -0400
Date: Sun, 27 Jul 2003 19:41:08 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problems with Linux 2.6.0-test1-bk3 regarding ACPI
Message-ID: <20030727174108.GA2208@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello folks,

I am experiencing an unexpected problem with Linux 2.6.0-test1-bk3 on
my Acer TravelMate 800LCi Centrino Notebook (Intel 855PM, Pentim M at
1.3GHz). It appears ACPI loads fine at boot time but after I logged in,=20
there is no /proc/acpi/sleep which is necessary to send the notebook=20
into sleep state and the like. Is this maybe a known problem is a fix=20
for it available somewhere? If you need other information like the=20
dmesg output or something else, let me know please.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JA60HPo+jNcUXjARAsUBAJwPUStVHnRdV/aYKkyF0jNwSejKcgCfa0g/
I6PEn8kuTp8N6dfUVB678tU=
=XKH6
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
