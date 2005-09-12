Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVILUQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVILUQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVILUQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:16:59 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21137 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932212AbVILUQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:16:57 -0400
Message-Id: <200509122016.j8CKGjmY029390@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Hugh Dickins <hugh@veritas.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Tainted lsmod output 
In-Reply-To: Your message of "Mon, 12 Sep 2005 20:58:01 BST."
             <Pine.LNX.4.61.0509122055520.5255@goblin.wat.veritas.com> 
From: Valdis.Kletnieks@vt.edu
References: <4325C713.6060908@latinsourcetech.com> <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net> <Pine.LNX.4.61.0509122039350.5019@goblin.wat.veritas.com> <Pine.LNX.4.50.0509121253300.30198-100000@shark.he.net>
            <Pine.LNX.4.61.0509122055520.5255@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126556205_2852P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 16:16:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126556205_2852P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Sep 2005 20:58:01 BST, Hugh Dickins said:
> On Mon, 12 Sep 2005, Randy.Dunlap wrote:
> > On Mon, 12 Sep 2005, Hugh Dickins wrote:
> > >
> > > The one that puzzles me greatly isn't listed there: 'G'
> > 
> > I guess it means GPL.
> > 
> > It's just the opposite of 'P', whereas all of the others
> > have opposites of ' '.
> 
> I guess the same, but doesn't it seem a strange kind of taint?

Somebody had an automated log-parsing tool, and wanted to make sure there
were guaranteed at least 2 non-whitespace tokens on the line so they wouldn't
have to deal with parsing 'Tainted:       \n'?


--==_Exmh_1126556205_2852P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDJeItcC3lWbTT17ARAoI9AJ9PpOma1y6PsYsIhfiwh4D7oEHBdACgjE+1
M39F8d47YVOa8bPH9p0OADI=
=e9RQ
-----END PGP SIGNATURE-----

--==_Exmh_1126556205_2852P--
