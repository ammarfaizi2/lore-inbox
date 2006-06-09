Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWFIWvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWFIWvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWFIWvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:51:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39093 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932572AbWFIWvA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:51:00 -0400
Message-Id: <200606092249.k59MnoqD015785@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mike Snitzer <snitzer@gmail.com>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hch@infradead.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: Your message of "Fri, 09 Jun 2006 23:22:23 +0400."
             <m3odx26snk.fsf@bzzz.home.net>
From: Valdis.Kletnieks@vt.edu
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org> <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com> <4489C3D5.4030905@garzik.org>
            <m3odx26snk.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149893388_4124P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 18:49:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149893388_4124P
Content-Type: text/plain; charset=us-ascii

On Fri, 09 Jun 2006 23:22:23 +0400, Alex Tomas said:
> what if proposed patch is safer than an average fix?
> (given that it's just out of usage unless enabled)

Those are the *dangerous* patches, because they usually contain bugs
that weren't tripped over by the 6 people who enabled it while it
was bouncing around in the -mm tree....

--==_Exmh_1149893388_4124P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEifsJcC3lWbTT17ARAhhvAJ0V+22VSEwjXoDcp8K05lYPGMhlKACg2AcC
2OkE9tyXQOUjWdFDPHtzbks=
=1jvq
-----END PGP SIGNATURE-----

--==_Exmh_1149893388_4124P--
