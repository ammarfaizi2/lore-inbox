Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUCKPs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCKPs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:48:26 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61824 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261416AbUCKPsY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:48:24 -0500
Message-Id: <200403111548.i2BFmEdT012204@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0) 
In-Reply-To: Your message of "Thu, 11 Mar 2004 10:22:49 EST."
             <Pine.LNX.4.53.0403111020230.28486@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos> <200403111503.i2BF3uDY010930@turing-police.cc.vt.edu>
            <Pine.LNX.4.53.0403111020230.28486@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2034484702P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Mar 2004 10:48:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2034484702P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 Mar 2004 10:22:49 EST, "Richard B. Johnson" said:

> No, and if you bothered to look at any code in the kernel, you'd
> note that uid and friends are always associated with some little
> pointy thingys. So, it wouldn't have been coded anything like that,
> anyway.

Fine. 

+       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))

Happy???

--==_Exmh_2034484702P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAUIo9cC3lWbTT17ARAt2aAKCLdjPrhgwRy5dR+1PohgKVzfkDwQCguH/c
p2EjU1clEVDRLLV6BtaJlsQ=
=zQ/W
-----END PGP SIGNATURE-----

--==_Exmh_2034484702P--
