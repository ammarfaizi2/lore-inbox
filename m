Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbTA2SqL>; Wed, 29 Jan 2003 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTA2SqL>; Wed, 29 Jan 2003 13:46:11 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44929 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266384AbTA2SqJ>; Wed, 29 Jan 2003 13:46:09 -0500
Message-Id: <200301291855.h0TItM4K007010@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.org frontpage 
In-Reply-To: Your message of "Wed, 29 Jan 2003 13:36:55 EST."
             <3E381F47.8060200@nortelnetworks.com> 
From: Valdis.Kletnieks@vt.edu
References: <200301290947.h0T9lKa9000750@darkstar.example.net> <3E37A46B.4080907@zytor.com> <200301291509.h0TF9S4K003537@turing-police.cc.vt.edu> <3E3819CB.2090409@zytor.com>
            <3E381F47.8060200@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1509176846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jan 2003 13:55:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1509176846P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Jan 2003 13:36:55 EST, Chris Friesen said:

> Perhaps for the truly paranoid the signatures should be posted to this 
> newsgroup and digitally signed by someone trusted.

It's called the PGP web of trust.  There's already some 107 signatures on
the PGP key - who else would you want signing it?  The point is that we've
already (presumably) proved via the web-of-trust that PGP key 517d0f0e is
in fact the proper key, and that for an intruder to post a valid signature
of a trojaned .tar.gz would require them to *ALSO* compromise the machine
that the signing is done on (hopefully a different machine than ftp.kernel.org).

Yes, an intruder could leave a forged signature with a random key easily. But
to leave a forged signature with the key that's already on my keyring is a
lot harder...
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1509176846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+OCOacC3lWbTT17ARAu1KAKDxk7z1drCwA4dGU1Pj4vdCf+B+HgCfermc
xxknXTd1OSCM5HTifotcN7g=
=Cu1g
-----END PGP SIGNATURE-----

--==_Exmh_1509176846P--
