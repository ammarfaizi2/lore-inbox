Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVIGJ6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVIGJ6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVIGJ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:58:40 -0400
Received: from h80ad25ab.async.vt.edu ([128.173.37.171]:38887 "EHLO
	h80ad25ab.async.vt.edu") by vger.kernel.org with ESMTP
	id S932094AbVIGJ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:58:39 -0400
Message-Id: <200509070958.j879w4p0017726@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "Budde, Marco" <budde@telos.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++ 
In-Reply-To: Your message of "Wed, 07 Sep 2005 11:13:24 +0200."
             <809C13DD6142E74ABE20C65B11A2439809C4BE@www.telos.de> 
From: Valdis.Kletnieks@vt.edu
References: <809C13DD6142E74ABE20C65B11A2439809C4BE@www.telos.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126087078_3088P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Sep 2005 05:57:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126087078_3088P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Sep 2005 11:13:24 +0200, "Budde, Marco" said:

> E.g. in my case the Windows source code has got more than 10 MB.
> Nobody will convert such an amount of code from C++ to C.
> This would take years.

Do you have any *serious* intent to drop 10 *megabytes* worth of driver
into the kernel??? (Hint - *everything* in drivers/net/wireless *totals*
to only 2.7M).

A Linux device driver isn't the same thing as a Windows device driver - much of
a Windows driver is considered "userspace" on Linux, and you're free to do that
in C++ if you want.



--==_Exmh_1126087078_3088P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHrmmcC3lWbTT17ARAn+zAJ9unG7oiTOr7kBdJhPpNEIR/7BGIACgk54B
Bcs7zgdmlcuWAjhQHiPeTeo=
=NNUz
-----END PGP SIGNATURE-----

--==_Exmh_1126087078_3088P--
