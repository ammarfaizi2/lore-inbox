Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274977AbUKASW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274977AbUKASW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbUKARbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:31:43 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35767 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S281280AbUKAR3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:29:02 -0500
Message-Id: <200411011728.iA1HSu5m022380@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Jesus Delgado <jdelgado@gmail.com>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working 
In-Reply-To: Your message of "Mon, 01 Nov 2004 09:30:13 CST."
             <5786143704110107302e1722d8@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <200410311903.06927@zodiac.zodiac.dnsalias.org>
            <5786143704110107302e1722d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-328228590P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 01 Nov 2004 12:28:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-328228590P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 Nov 2004 09:30:13 CST, Jesus Delgado said:

>     Iam have is the same problems, kernel 2.6.10-rc1 keryboard and
> mouse OK ( emachines M6709), both running kernel 2.6.10-rc1-mm2 the
> keyboard and mouse NOT WORKING.

I had issues in 2.6.10-rc1-mm2 and no keyboard input at all, I tracked
it down to CONFIG_ACPI_CONTAINER - haven't checked if i8042.noacpi
fixes the problem also.

--==_Exmh_-328228590P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBhnJVcC3lWbTT17ARAsRiAKDVZP4RjhRolecibOSIscJPEICNRACg/a8H
caNudB0ViSuqG833GG32ccA=
=JOWf
-----END PGP SIGNATURE-----

--==_Exmh_-328228590P--
