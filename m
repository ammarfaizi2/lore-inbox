Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269232AbUIBWrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269232AbUIBWrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUIBWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:45:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56728 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269185AbUIBWnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:43:33 -0400
Message-Id: <200409022239.i82MdmnO015327@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Spam <spam@tnonline.net>
Cc: Oliver Hunt <oliverhunt@gmail.com>, Helge Hafting <helge.hafting@hist.no>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives 
In-Reply-To: Your message of "Thu, 02 Sep 2004 12:02:59 +0200."
             <812032218.20040902120259@tnonline.net> 
From: Valdis.Kletnieks@vt.edu
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com>
            <812032218.20040902120259@tnonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1254368776P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 18:39:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1254368776P
Content-Type: text/plain; charset=us-ascii

On Thu, 02 Sep 2004 12:02:59 +0200, Spam said:

>   The meta-data should be deleted if it the file is copied or moved to
>   a medium that doesn't support it. However a _warning_ may be shown
>   to the user if there is risk to loose data.

OK... I'll bite.  How do you report the warning to the user if you're using
an unenhanced utility to copy a file to a file system that may be lossy?

--==_Exmh_1254368776P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN6E0cC3lWbTT17ARAvFtAKCYXKO1PT6wSczb1JWdAFaNawpmFgCghAzb
kO4/aGfmuLqZJD/PIF8iDgw=
=PWgb
-----END PGP SIGNATURE-----

--==_Exmh_1254368776P--
