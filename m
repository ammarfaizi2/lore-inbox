Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUKCWFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUKCWFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUKCWEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:04:50 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20702 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261897AbUKCV5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:57:17 -0500
Message-Id: <200411032157.iA3LvA4i019705@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers 
In-Reply-To: Your message of "Wed, 03 Nov 2004 22:37:10 +0100."
             <41894F86.7070405@debian.org> 
From: Valdis.Kletnieks@vt.edu
References: <41894779.10706@techsource.com> <20041103211714.GP12275@mea-ext.zmailer.org>
            <41894F86.7070405@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1303417750P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Nov 2004 16:57:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1303417750P
Content-Type: text/plain; charset=us-ascii

On Wed, 03 Nov 2004 22:37:10 +0100, "Giacomo A. Catenazzi" said:

> But is it Linux the biggest compiler bug finder?
> So forcing a newer compiler in other architectures should
> improve also the quality of code generation.

However, the problem is that I probably want to compile a working
kernel *now*, not when the GCC people finally get around to fixing
the b0rkedness they added for my architecture in gcc 3.2.3.  So I
get to keep 3.2.2 around until it's fixed.  (Feel free to replace
3.2.3 with whatever arch-dependent value you like).


--==_Exmh_-1303417750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiVQ1cC3lWbTT17ARArIUAJsHTfOziwNjRzHE+dj15AF3Q1HCmgCgglQ4
DcaDq+omq/TGgqaS+U5GcGI=
=gbtl
-----END PGP SIGNATURE-----

--==_Exmh_-1303417750P--
