Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUAYSDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUAYSDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:03:41 -0500
Received: from h80ad2489.async.vt.edu ([128.173.36.137]:41389 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265105AbUAYSDj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:03:39 -0500
Message-Id: <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andi Kleen <ak@muc.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED 
In-Reply-To: Your message of "Sun, 25 Jan 2004 18:48:37 +0100."
             <20040125174837.GB16962@colin2.muc.de> 
From: Valdis.Kletnieks@vt.edu
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de>
            <20040125174837.GB16962@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1220224214P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Jan 2004 13:00:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1220224214P
Content-Type: text/plain; charset=us-ascii

On Sun, 25 Jan 2004 18:48:37 +0100, Andi Kleen said:

> It works for me with the hammer branch gcc 3.3 with -funit-at-a-time.

> Are you sure the exception table sorting patch was properly applied?

Was that patch an x86 issue as well, or only on the 64-bit boxes?  And if it
is a x86 issue, can you repost what *you* think it is (as opposed to what the -mm
patch thinks it is?)


--==_Exmh_-1220224214P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAFAQ7cC3lWbTT17ARAld5AJ9eMApLkxSmF5DsgWz/FxJBFUX1XACgjbO4
WQ1bz1Aki60lU4ZVko26swE=
=9pzO
-----END PGP SIGNATURE-----

--==_Exmh_-1220224214P--
