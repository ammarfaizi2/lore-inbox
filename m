Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbUKDRFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUKDRFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbUKDRFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:05:36 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36575 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262297AbUKDRFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:05:15 -0500
Message-Id: <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Adam Heath <doogie@debian.org>
Cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers 
In-Reply-To: Your message of "Thu, 04 Nov 2004 10:50:38 CST."
             <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> 
From: Valdis.Kletnieks@vt.edu
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org>
            <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1647897724P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Nov 2004 12:04:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1647897724P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Nov 2004 10:50:38 CST, Adam Heath said:

> I didn't deny the speed difference of older and newer compilers.
> 
> But why is this an issue when compiling a kernel?  How often do you compile
> your kernel?

If you're working on older hardware (note the number of people on this
list still using 500mz Pentium3 and similar), and a kernel developer, the
difference between 2 hours to build a kernel and 4 hours to build a
kernel matters quite a bit.

--==_Exmh_1647897724P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBimE0cC3lWbTT17ARArfbAKCpjL6sYpCpLpGVkR0DBH7UczSW9wCgq4nw
CqN2qzLG9XKtCGnIpxoHdAI=
=yIvt
-----END PGP SIGNATURE-----

--==_Exmh_1647897724P--
