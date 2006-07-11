Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWGKPji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWGKPji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWGKPji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:39:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21130 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751294AbWGKPjh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:39:37 -0400
Message-Id: <200607111539.k6BFdOe7009914@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: patch for timer.c
In-Reply-To: Your message of "Tue, 11 Jul 2006 17:19:32 +0200."
             <20060711151932.19310@gmx.net>
From: Valdis.Kletnieks@vt.edu
References: <20060711151932.19310@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152632364_5755P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 11:39:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152632364_5755P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2006 17:19:32 +0200, Uwe Bugla said:

> BUT: This is a Pentium-4-only solution. On my file server, which is a P=
entium
> 3 machine, the kernel stops booting and hangs the machine, no matter if=
 I use
> framebuffer console with vga=3D791 or not.

Odd.. there wasn't anything P4-specific in that patch..

> Would you please try to find a fix for every architecture at any speed?=


Are you *positive* that your Pentium3 box is hanging up for the same reas=
on?
It could be it's something else entirely.  What point does it hang at, an=
d
does sysrq-T tell you anything useful?

--==_Exmh_1152632364_5755P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEs8YscC3lWbTT17ARAjKDAJ4pxljHXcsLJJudHgIg15oOwHdeYgCgkCOm
zPzh1vjK5KzMZ5tVlftHGfc=
=kPys
-----END PGP SIGNATURE-----

--==_Exmh_1152632364_5755P--
