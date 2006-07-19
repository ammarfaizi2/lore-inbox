Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030178AbWGSPYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWGSPYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWGSPYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:24:07 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:29891 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030178AbWGSPYF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:24:05 -0400
Message-Id: <200607191523.k6JFNpCu009024@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Erik Mouw <erik@harddisk-recovery.com>, chinmaya@innomedia.soft.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Gettin own IP address thorugh ioctl in kernel space.
In-Reply-To: Your message of "Wed, 19 Jul 2006 17:07:47 +0200."
             <Pine.LNX.4.61.0607191707040.2311@yvahk01.tjqt.qr>
From: Valdis.Kletnieks@vt.edu
References: <44BDFC64.607@innomedia.soft.net> <20060719115629.GB22306@harddisk-recovery.com>
            <Pine.LNX.4.61.0607191707040.2311@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153322631_2943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2006 11:23:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153322631_2943P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jul 2006 17:07:47 +0200, Jan Engelhardt said:
> >> 
> >> How to port this in keernel space.
> >
> >Not. For the same reasons why you shouldn't read files from kernel
> >space.
> >
> About reading files, tell that
>  - ndiswrapper
>  - ralink drivers from RaLinkTech and Serialmonkey

Out-of-tree code involving binary blobs shouldn't be held up as examples of
how we do things in-tree....

--==_Exmh_1153322631_2943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvk6HcC3lWbTT17ARAnGoAKCF8UBO1MNft3ouyarwyOJP8jfAwACgrLvB
FqAVNYCV7VEFs642RHI2PV0=
=ZlET
-----END PGP SIGNATURE-----

--==_Exmh_1153322631_2943P--
