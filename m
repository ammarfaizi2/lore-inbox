Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbTBJEQg>; Sun, 9 Feb 2003 23:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTBJEQg>; Sun, 9 Feb 2003 23:16:36 -0500
Received: from h80ad26eb.async.vt.edu ([128.173.38.235]:22156 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261486AbTBJEQf>; Sun, 9 Feb 2003 23:16:35 -0500
Message-Id: <200302100426.h1A4Q8Of022645@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Edward Kuns <ekuns@kilroy.chi.il.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Larger circular printk log message buffer for kernel? 
In-Reply-To: Your message of "Sun, 09 Feb 2003 22:20:03 CST."
             <1044850803.14790.18.camel@kilroy.chi.il.us> 
From: Valdis.Kletnieks@vt.edu
References: <1044850803.14790.18.camel@kilroy.chi.il.us>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_480515072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Feb 2003 23:26:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_480515072P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Feb 2003 22:20:03 CST, you said:
> Please CC me for responses.
> 
> I'm willing to make a patch if it is likely to be accepted into the
> kernel.  Since we have so many subsystems that spit out kilobytes of
> messages, by the time my system has booted up I have already lost some
> of the most important boot messages!  (APIC, for example)

There's a version of this already in the 2.5 tree.

--==_Exmh_480515072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+RyngcC3lWbTT17ARAtJ5AKDMHi216rOq+15ZjE1LnHpQ8KlW3QCeOpjA
kjegE9T9YhWcylo9tdmJICM=
=btcM
-----END PGP SIGNATURE-----

--==_Exmh_480515072P--
