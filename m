Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCKPEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUCKPEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:04:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43392 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261380AbUCKPE2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:04:28 -0500
Message-Id: <200403111503.i2BF3uDY010930@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0) 
In-Reply-To: Your message of "Wed, 10 Mar 2004 13:33:53 EST."
             <Pine.LNX.4.53.0403101324120.18709@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org>
            <Pine.LNX.4.53.0403101324120.18709@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2002632292P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Mar 2004 10:03:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2002632292P
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Mar 2004 13:33:53 EST, "Richard B. Johnson" said:

> People who develop kernel code know the difference between
> '==' and '=' and are never confused my them. If you make

Remember a few months ago when a lot of very clever people looked at
a line of code that said 'if (yadda yadda && (uid = 0))' that had been
inserted into the CVS tree, and it took a while for some of the very clever
people to notice the equally clever hack?

--==_Exmh_2002632292P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAUH/ccC3lWbTT17ARAog6AJsGKiKkanocOb0LY86jxGhcKVteqwCfQCCg
dCOSs9Hx/ACYbNVddYgdKnc=
=Rq0m
-----END PGP SIGNATURE-----

--==_Exmh_2002632292P--
