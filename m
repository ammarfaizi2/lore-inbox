Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269283AbUIBXXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269283AbUIBXXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbUIBXV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:21:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4528 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269283AbUIBXVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:21:14 -0400
Message-Id: <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4) 
In-Reply-To: Your message of "Thu, 02 Sep 2004 22:38:54 +0200."
             <20040902203854.GA4801@janus> 
From: Valdis.Kletnieks@vt.edu
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain>
            <20040902203854.GA4801@janus>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1353348402P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 19:19:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1353348402P
Content-Type: text/plain; charset=us-ascii

On Thu, 02 Sep 2004 22:38:54 +0200, Frank van Maarseveen said:

> Can it do this:
> 
> 	cd FC2-i386-disc1.iso
> 	ls

That one's at least theoretically doable, assuming that it really *IS* the
Fedora Core disk and an ISO9660 format...

> 	cd /dev/cdrom
> 	ls

And the CD in the drive at the moment is AC/DC "Back in Black".  What
should this produce as output?

--==_Exmh_1353348402P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN6qScC3lWbTT17ARApkUAKCcJAifgzFxoZKZ6gRFUT29tgxsmgCfSjhn
KGzfGdsdlgw4H7i8i2mE570=
=uwwQ
-----END PGP SIGNATURE-----

--==_Exmh_1353348402P--
