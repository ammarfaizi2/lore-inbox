Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270887AbTGPKZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270878AbTGPKZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:25:03 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:63111 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S270887AbTGPKYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:24:00 -0400
Date: Wed, 16 Jul 2003 06:38:51 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2 2.6.0-test1 issues
Message-ID: <20030716103851.GH2412@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Didn't see anything relevant in the Changes file or a grep through
Documentation dir.

I can SSH out of my 2.6.0-test1 box (IPv4 and IPv6).  When I try to ssh
in though I get a prompt for a passphrase like normal but once I enter
it nothing happens it just hangs there.

On bootup I get multiple FATAL messages about tty and ttyS.  They're
scattered throughout the startup process and don't seem tied to any
particular init scripts.

Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FSs78+1vMONE2jsRAnXBAKCvjMd5PF3frqFY4JT/Vg68D6EmPACdFi90
vaHohYCB2LXQ1dVhlIMaRdc=
=qW2Y
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
