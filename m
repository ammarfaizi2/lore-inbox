Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270842AbTGNU7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270840AbTGNU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:57:55 -0400
Received: from NeverAgain.DE ([217.69.76.1]:2495 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S270829AbTGNU4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:56:44 -0400
Date: Mon, 14 Jul 2003 23:11:17 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 refuses to boot
Message-ID: <20030714211117.GA2931@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm wanting to test 2.6 and I want to do this on my Acer TravelMate 800 LCi.
However, booting the kernel is not possible here, it always panics at boot
time with the following message: 'VFS: unable to open root device "hda2" or
hda2'. I am using DevFS, with 2.4, it works flawless.

For a very short time, I ran 2.5.70-bk18 on this machine and there it worked
just fine. Chipset is Intel 855PM. I'd really be grateful if somebody was
able to help me with this.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Exx1HPo+jNcUXjARAkbuAKCIc/1s6sTsLN2517loOryCUWsYFACeLenW
6RUrutoZnDTqhxywETRYNAs=
=LTyZ
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
