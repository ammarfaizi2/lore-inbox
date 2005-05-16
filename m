Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVEPSSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVEPSSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEPSLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:11:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22546 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261791AbVEPSL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:11:27 -0400
Message-Id: <200505161811.j4GIB3XF010414@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability) 
In-Reply-To: Your message of "Mon, 16 May 2005 10:33:30 EDT."
             <4288AF3A.2000008@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl> <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz> <20050516111859.GB13387@merlin.emma.line.org>
            <4288AF3A.2000008@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116267062_5623P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 May 2005 14:11:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116267062_5623P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 May 2005 10:33:30 EDT, Jeff Garzik said:

> Upon power loss, at least one ATA vendor's disks try to write out as 
> much data as possible.

Does the firmware for this vendor's disks have enough smarts to reserve that
last little bit of power to park the heads so it's not actively writing when
it finally loses entirely?

--==_Exmh_1116267062_5623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiOI2cC3lWbTT17ARAl/nAKCvrVwYufm1LUz2+7+R/lzlbYvNogCghqKP
YVm7Hg6xNAOESoJBSagzMhg=
=hoVa
-----END PGP SIGNATURE-----

--==_Exmh_1116267062_5623P--
