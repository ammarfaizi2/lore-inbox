Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHJVpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHJVpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWHJVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:45:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13750 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932092AbWHJVpK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:45:10 -0400
Message-Id: <200608102144.k7ALisOD003046@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Patrick McHardy <kaber@trash.net>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       Thomas Graf <tgraf@suug.ch>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - IPV6_MULTIPLE_TABLES borked....
In-Reply-To: Your message of "Thu, 10 Aug 2006 22:02:03 +0200."
             <44DB90BB.7050302@trash.net>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608101738.k7AHcx9V004680@turing-police.cc.vt.edu>
            <44DB90BB.7050302@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155246294_2992P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 17:44:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155246294_2992P
Content-Type: text/plain; charset=us-ascii

On Thu, 10 Aug 2006 22:02:03 +0200, Patrick McHardy said:

> Valdis.Kletnieks@vt.edu wrote:
> > On Sun, 06 Aug 2006 03:08:09 PDT, Andrew Morton said:
> > 
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > 
> > 
> > Building a kernel with IPV6_MULTIPLE_TABLES=y breaks my IPv6 connectivity

> It should be fixed by this patch (already contained in net-2.6.19).

Confirmed fixed, thanks...

--==_Exmh_1155246294_2992P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE26jWcC3lWbTT17ARAn2tAKDgjOFosjADrGkLbgmS3xNtaGP0sgCbB6oS
BOIR2nEnd7K7V+q7qzXX4+s=
=CgWp
-----END PGP SIGNATURE-----

--==_Exmh_1155246294_2992P--
