Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbTAHV6W>; Wed, 8 Jan 2003 16:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTAHV6T>; Wed, 8 Jan 2003 16:58:19 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54146 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267896AbTAHV6S>; Wed, 8 Jan 2003 16:58:18 -0500
Message-Id: <200301082206.h08M6pRA014912@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ?? 
In-Reply-To: Your message of "Wed, 08 Jan 2003 13:51:18 PST."
             <Pine.LNX.4.33L2.0301081351010.6873-100000@dragon.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.33L2.0301081351010.6873-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1411371710P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Jan 2003 17:06:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1411371710P
Content-Type: text/plain; charset=us-ascii

On Wed, 08 Jan 2003 13:51:18 PST, "Randy.Dunlap" said:
> On Wed, 8 Jan 2003, John Bradford wrote:
> 
> | > > What I was thinking of was a virtual device that allocated a new
> | > > sector whenever an old one was overwritten - kind of like a journaled
> | > > filesystem, but without the filesystem, (I.E. just the journal) :-).
> | >
> | > $ DIR FOO.TXT;*
> | > FOO.TXT;1   FOO.TXT;2   FOO.TXT;2
> | >
> | > VMS-style file versioning, anybody? ;)
> |
> | Brilliant!
> 
> re-read the archives from 6-8 months ago.

http://marc.theaimsgroup.com/?l=linux-kernel&m=101914252421742&w=2

--==_Exmh_1411371710P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+HKD7cC3lWbTT17ARAmeTAJ97c+fI5osixaGYlHX4BytA5WdZ0wCg85E/
EmzqPO8qTMZO1h17vZPULlQ=
=Dnxx
-----END PGP SIGNATURE-----

--==_Exmh_1411371710P--
