Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTKFTX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTKFTX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:23:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13184 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263728AbTKFTX0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:23:26 -0500
Message-Id: <200311061922.hA6JMsHG003109@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: viro@parcelfarce.linux.theplanet.co.uk, Marcel Lanz <marcel.lanz@ds9.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: load 2.4.x binary only module on 2.6 
In-Reply-To: Your message of "Thu, 06 Nov 2003 12:43:19 EST."
             <200311061243.19536.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <20031106153004.GA30008@ds9.ch> <20031106155815.GQ7665@parcelfarce.linux.theplanet.co.uk> <200311061606.hA6G6Jf4026228@turing-police.cc.vt.edu>
            <200311061243.19536.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-950502366P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Nov 2003 14:22:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-950502366P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Nov 2003 12:43:19 EST, Gene Heskett said:

> It may be there, and I may have a copy of it, but it won't install if 
> I'm running 2.6.0-test9-mm2.

Huh?  I'm running -test9-mm2 with the minion stuff as I'm typing this.

Or are you talking about the general case if you have a wrapper for
a 2.4 kernel?  If so, then yes, you'll need to do some programming to
get the wrapper to do things the 2.6 way (which is what minion's patch
basically does, it changes the NVidia 2.4 wrapper code to the 2.6 schemes).

--==_Exmh_-950502366P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qp+OcC3lWbTT17ARAlYCAKDIOu6CHunC/4gbJXu7yFV3bVO9CACfebHB
ITDGeb646tfG3bRJ5AGTILU=
=r4dc
-----END PGP SIGNATURE-----

--==_Exmh_-950502366P--
