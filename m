Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTAHVZN>; Wed, 8 Jan 2003 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267908AbTAHVZN>; Wed, 8 Jan 2003 16:25:13 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37762 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267886AbTAHVZM>; Wed, 8 Jan 2003 16:25:12 -0500
Message-Id: <200301082133.h08LXlRA014406@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ?? 
In-Reply-To: Your message of "Wed, 08 Jan 2003 10:57:01 GMT."
             <200301081057.h08Av1og000585@darkstar.example.net> 
From: Valdis.Kletnieks@vt.edu
References: <200301081057.h08Av1og000585@darkstar.example.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1379394798P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Jan 2003 16:33:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1379394798P
Content-Type: text/plain; charset=us-ascii

On Wed, 08 Jan 2003 10:57:01 GMT, John Bradford said:

> What I was thinking of was a virtual device that allocated a new
> sector whenever an old one was overwritten - kind of like a journaled
> filesystem, but without the filesystem, (I.E. just the journal) :-).

$ DIR FOO.TXT;*
FOO.TXT;1   FOO.TXT;2   FOO.TXT;2

VMS-style file versioning, anybody? ;)

--==_Exmh_1379394798P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+HJk7cC3lWbTT17ARAq5sAJ4uDMne9tofPN4TxVKv4t+qWLz3YQCbBV+e
ysYy3mJ/RP4d+t37rKndtBo=
=4W2r
-----END PGP SIGNATURE-----

--==_Exmh_1379394798P--
