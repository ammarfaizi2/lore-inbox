Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTEZPSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTEZPSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 11:18:05 -0400
Received: from h80ad26a4.async.vt.edu ([128.173.38.164]:7316 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262000AbTEZPSE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 11:18:04 -0400
Message-Id: <200305261531.h4QFVDa7011934@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Janitors, or Illuminati?
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1518020223P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 May 2003 11:31:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1518020223P
Content-Type: text/plain; charset=us-ascii

While we're on the "Why didn't you send the patches to the right place?" topic..

The Kernel Janitors are often referenced, but there's not much of a pointer
to them in the source tree.

% cd /usr/src/linux-2.5.69
% grep -ri janitor .
./fs/affs/Changes:- sizeof changes from Kernel Janitor Project
./include/asm-sparc/elf.h:} while(0); /* Janitors: Don't touch this colon. */
./CREDITS:D: Various Janitor work.
./CREDITS:D: petty kernel janitor (byteorder, ufs)

The lines in CREDITS reference Dave Jones and Francois-Rene Rideau.

I'm not sure if MAINTAINERS is the right place for a blurb for them,
or if it should be elsewhere.  Any opinions?

--==_Exmh_-1518020223P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+0jNAcC3lWbTT17ARAkrHAJ0SxiT69hxofUZxnUmqRnWyLoXZ3gCbBQcO
b5qC8Gmeu5rcJ4TL9IF2L3c=
=sGNH
-----END PGP SIGNATURE-----

--==_Exmh_-1518020223P--
