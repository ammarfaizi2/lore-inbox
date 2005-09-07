Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVIGCeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVIGCeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVIGCeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:34:11 -0400
Received: from h80ad2565.async.vt.edu ([128.173.37.101]:27029 "EHLO
	h80ad2565.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750740AbVIGCeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:34:10 -0400
Message-Id: <200509070233.j872XcGh007159@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, "Budde, Marco" <budde@telos.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++ 
In-Reply-To: Your message of "Wed, 07 Sep 2005 00:20:11 +0200."
             <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126060417_3250P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 22:33:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126060417_3250P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Sep 2005 00:20:11 +0200, Esben Nielsen said:

> Which is too bad. You can do stuff much more elegant, effectively and
> safer in C++ than in C. Yes, you can do inheritance in C, but it leaves
> it up to the user to make sure the type-casts are done OK every time. You
> can with macros do some dynamic typing, but not nearly as effectively as
> with templates, and those macros always comes very, very ugly. (Some say
> templates are ugly, but they first become ugly when they are used
> way beyond what you can do with macros.)
> 
> I think it can only be a plus to Linux to add C++ support for at least
> out-of-mainline drivers. Adding drivers written in C++ into the mainline
> is another thing.

http://www.tux.org/lkml/#s15-3 Why don't we rewrite the Linux kernel in C++?

--==_Exmh_1126060417_3250P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHlGBcC3lWbTT17ARAs/cAJ94BFx2Wpg2+ZlgHO2m7HbjpzV8GACgwNhF
gW7amzTmKiIXYY0y6fvWkwA=
=yIVN
-----END PGP SIGNATURE-----

--==_Exmh_1126060417_3250P--
