Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTJJQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTJJQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:27:45 -0400
Received: from h80ad2693.async.vt.edu ([128.173.38.147]:32648 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263007AbTJJQ1l (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:27:41 -0400
Message-Id: <200310101627.h9AGRW1M012975@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup... 
In-Reply-To: Your message of "Fri, 10 Oct 2003 09:00:23 PDT."
             <Pine.LNX.4.44.0310100839030.20420-100000@home.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310100839030.20420-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1115093500P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Oct 2003 12:27:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1115093500P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Oct 2003 09:00:23 PDT, Linus Torvalds said:

> I'm hoping in-memory databases will just kill off the current crop 
> totally. That solves all the IO problems - the only thing that goes to 
> disk is the log and the backups, and both go there totally linearly unless 
> the designer was crazy.

I can process a 100GB database on a current 2U Dell rackmount server. I hesitate to
think about what would be required to deal with a terabyte-sized database...



--==_Exmh_-1115093500P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ht30cC3lWbTT17ARAk2gAJoDN3dOWYVZvQvFEXE5nBV1uZtDHgCfVW1S
a4KMONPKuZeBjW4QRt3YeWc=
=Yoz0
-----END PGP SIGNATURE-----

--==_Exmh_-1115093500P--
