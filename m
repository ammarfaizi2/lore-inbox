Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbTAKAcx>; Fri, 10 Jan 2003 19:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbTAKAcx>; Fri, 10 Jan 2003 19:32:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45954 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266763AbTAKAcw>; Fri, 10 Jan 2003 19:32:52 -0500
Message-Id: <200301110041.h0B0fWLK016406@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs that are resolved but not closed in Bugzilla 
In-Reply-To: Your message of "Fri, 10 Jan 2003 16:16:52 PST."
             <306150000.1042244212@flay> 
From: Valdis.Kletnieks@vt.edu
References: <306150000.1042244212@flay>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1285645520P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 19:41:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1285645520P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 16:16:52 PST, "Martin J. Bligh" <mbligh@aracnet.com>  said:
> There are 31 bugs in RESOLVED state in Bugzilla, but not CLOSED.
> Either they should be closed, or there's a patch available that's not pushed.
> 
> If the patch is merged into Linus's tree, please could you close them out,
> or send me email and I will?

> 128 nor mbligh@aracnet.com RESO CODE 2.5.50 CONFIG_ACPI_SLEEP fails to build 
without

I filed this one, and have verified that Dave Jones did merge my patch into
2.5.51 - got a 'mid air collision' trying to close it.  Hope that was
you, Martin.. ;)
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1285645520P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+H2g8cC3lWbTT17ARAk1YAJ4uxEgwHd+s7MUpDBX4MpvzIaU3SgCg7qMI
HGAU9/MIWm0UVkNKPYuPrfg=
=WHie
-----END PGP SIGNATURE-----

--==_Exmh_-1285645520P--
