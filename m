Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVKZFup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVKZFup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 00:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVKZFup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 00:50:45 -0500
Received: from h80ad25ad.async.vt.edu ([128.173.37.173]:19662 "EHLO
	h80ad25ad.async.vt.edu") by vger.kernel.org with ESMTP
	id S932723AbVKZFuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 00:50:44 -0500
Message-Id: <200511260549.jAQ5nJPG006592@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1 
In-Reply-To: Your message of "Wed, 23 Nov 2005 03:35:50 PST."
             <20051123033550.00d6a6e8.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20051123033550.00d6a6e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1132984146_2891P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 26 Nov 2005 00:49:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1132984146_2891P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Nov 2005 03:35:50 PST, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/

1) This boots on my laptop, so whatever caused the "reset and go back to Grub"
behavior in -rc1-mm1 and -rc1-mm2 has reseolved itself before I got far enough
on bisecting patches to track it down.

2) The strange "ppp traffic spins in kernel and kills keyboard" problem is still
here....

--==_Exmh_1132984146_2891P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDh/dScC3lWbTT17ARAjmoAKD7J1PdGvzIEfZq4Tf6CLLjebVNjACeJhHk
n73GjJiKWEkzYviaF23jM+I=
=igdf
-----END PGP SIGNATURE-----

--==_Exmh_1132984146_2891P--
