Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUEQX34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUEQX34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUEQX34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:29:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1189 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261673AbUEQX3z (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:29:55 -0400
Message-Id: <200405172329.i4HNTpGZ016512@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
Cc: "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug 
In-Reply-To: Your message of "Mon, 17 May 2004 19:18:37 EDT."
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1025329140P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 May 2004 19:29:51 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1025329140P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 May 2004 19:18:37 EDT, Valdis.Kletnieks@vt.edu said:

> > [tapebox:root]:(/mnt/floppy)# cp -ap bin boot cdrom dev etc floppy lib mnt proc root sbin tag tmp usr var /mnt/root
> 
> Were you expecting those to copy all the contents, or just the directories themselves?

Nevermind - I managed to miss that -a flag... :)

--==_Exmh_-1025329140P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAqUrucC3lWbTT17ARAgRyAKC8gUbFLgZRG7GUd8CDIc0ZM8ga5QCgm/+m
+5b9tGxMZJaP9mIztgEDr8A=
=7Y9d
-----END PGP SIGNATURE-----

--==_Exmh_-1025329140P--
