Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269547AbUICB5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269547AbUICB5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUICB4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:56:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35521 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269545AbUICBgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:36:32 -0400
Message-Id: <200409030135.i831ZDCE030095@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Hans Reiser <reiser@namesys.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Your message of "Thu, 02 Sep 2004 20:11:13 CDT."
             <4137C4B1.40308@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
            <4137C4B1.40308@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-13329608P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 21:35:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-13329608P
Content-Type: text/plain; charset=us-ascii

On Thu, 02 Sep 2004 20:11:13 CDT, David Masover said:

> It'd be like writing OpenGL entirely in software, before hardware
> accelerators work, and at the last minute have to change the library to
> use triangles instead of splines.

I expect that SGI did a software-only version of IrisGL first, so they could
figure out what the hardware accelerators needed to support.  And even then,
the API for IrisGL got modified when it became OpenGL.....


--==_Exmh_-13329608P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN8pQcC3lWbTT17ARArtnAJ9pjublEw96yrSlIphHtU92I+1zhACfRYtj
Y15nKf/qP89+UGC+xTbbAf4=
=BhBB
-----END PGP SIGNATURE-----

--==_Exmh_-13329608P--
