Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTELOQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbTELOQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:16:47 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:16768 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261928AbTELOQq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:16:46 -0400
Message-Id: <200305121429.h4CETPJ5005919@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Paul P Komkoff Jr <i@stingr.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Two RAID1 mirrors are faster than three 
In-Reply-To: Your message of "Mon, 12 May 2003 15:20:34 +0400."
             <20030512112034.GB1318@stingr.net> 
From: Valdis.Kletnieks@vt.edu
References: <200305112212_MC3-1-386B-32BF@compuserve.com> <3EBF24A8.1050100@tequila.co.jp> <1052716203.4100.10.camel@tor.trudheim.com> <3EBF5DF2.2080204@tequila.co.jp> <1052731825.3522.23.camel@tor.trudheim.com>
            <20030512112034.GB1318@stingr.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2052322040P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 May 2003 10:29:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2052322040P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 May 2003 15:20:34 +0400, Paul P Komkoff Jr <i@stingr.net>  said:
> Replying to Anders Karlsson:
> > I think it depends greatly on your needs. For small companies running
> > commercial unices, this might be the best solution based upon need and
> 
> As for commercial market veritas vxfs doing snapshots for ages :)

a) vxfs isn't free.
b) vxfs may not be available on the platform required by the application.
c) If you've already *got* platform A that doesn't have vxfs, you will probably
think *really* hard about migrating - there's the costs of buying the hardware,
software, and liveware....

> There are more efficient and less efficient ways ...

And often, a lot of inefficiency is overlooked. The cost of buying a new server
from another vendor, buying new licenses for all the software, installing it
all, arranging maintenance contracts, getting sysadmins with a clue regarding
the new system, and all the rest of the costs of a conversion can *easily*
outweigh any "less efficient" ways.


--==_Exmh_-2052322040P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+v6/EcC3lWbTT17ARAjnbAJ9Xx92fqqlM7qFziFvoLqJ0VHk1PQCeJvb9
+W10ukysJQitXM6QsxgfJ7k=
=B2us
-----END PGP SIGNATURE-----

--==_Exmh_-2052322040P--
