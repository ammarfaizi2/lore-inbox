Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbTA2Tkn>; Wed, 29 Jan 2003 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTA2Tkn>; Wed, 29 Jan 2003 14:40:43 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11650 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266535AbTA2Tkm>; Wed, 29 Jan 2003 14:40:42 -0500
Message-Id: <200301291949.h0TJnW4K007895@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.org frontpage 
In-Reply-To: Your message of "Wed, 29 Jan 2003 19:37:50 GMT."
             <20030129193750.D6261@flint.arm.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <200301290947.h0T9lKa9000750@darkstar.example.net> <3E37A46B.4080907@zytor.com> <200301291509.h0TF9S4K003537@turing-police.cc.vt.edu> <3E3819CB.2090409@zytor.com> <3E381F47.8060200@nortelnetworks.com> <200301291855.h0TItM4K007010@turing-police.cc.vt.edu>
            <20030129193750.D6261@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1530471676P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jan 2003 14:49:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1530471676P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Jan 2003 19:37:50 GMT, Russell King said:

> I believe a script signs the files on ftp.kernel.org, which means the
> private key is on the master machine, probably without a pass phrase.
> That means that if the master server is compromised, its highly likely
> that a rogue file will have a correct signature.

OK.. I missed that part, and thought somebody was doing a check-and-balance
before files went out.

> The only way to be completely sure is for Linus to gpg-sign the patches
> himself at source with a known gpg key using a secure pass phrase before

Now there's a thought.. ;)


--==_Exmh_1530471676P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+ODBMcC3lWbTT17ARAuZ7AKCdGYUrHtMoP0ZwPOiBPYhXcf1XcACg+oTI
7OTwJIhbDvcbpFI0PQJhuwE=
=0uzb
-----END PGP SIGNATURE-----

--==_Exmh_1530471676P--
