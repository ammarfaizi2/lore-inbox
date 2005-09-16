Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVIPXyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVIPXyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIPXyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:54:19 -0400
Received: from h80ad2524.async.vt.edu ([128.173.37.36]:56254 "EHLO
	h80ad2524.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750765AbVIPXyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:54:17 -0400
Message-Id: <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Greg KH <greg@kroah.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Jiri Slaby <jirislaby@gmail.com>,
       Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1 
In-Reply-To: Your message of "Fri, 16 Sep 2005 14:30:04 PDT."
             <20050916213003.GB13604@kroah.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net> <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org>
            <20050916213003.GB13604@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126914812_2813P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Sep 2005 19:53:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126914812_2813P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Sep 2005 14:30:04 PDT, Greg KH said:
> > > >On Friday 16 September 2005 11:23, Andrew Morton wrote:
> > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/

> Yes, Andrew, can you please drop these patches, they will cause lots of
> problems with users due to the above mentioned issues.

For those of us playing along at home -

Would doing a 'patch -R' of all 30 patches listed in "Big input/sysfs changes"
be needed? Or just the 'input-prepare-to-sysfs-integration.patch' and following?

--==_Exmh_1126914812_2813P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDK1r8cC3lWbTT17ARAu8EAJ9N2Y2OjwXW3OeW0teNAnXoY2EOCQCg7ciZ
5fYIFDWw6Qf9v/tlvhM75Es=
=Htis
-----END PGP SIGNATURE-----

--==_Exmh_1126914812_2813P--
