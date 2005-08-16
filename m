Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVHPCnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVHPCnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 22:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVHPCnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 22:43:23 -0400
Received: from h80ad2575.async.vt.edu ([128.173.37.117]:28565 "EHLO
	h80ad2575.async.vt.edu") by vger.kernel.org with ESMTP
	id S964856AbVHPCnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 22:43:22 -0400
Message-Id: <200508160243.j7G2h8qm010206@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support 
In-Reply-To: Your message of "Mon, 15 Aug 2005 18:38:49 CDT."
             <20050815233849.GA3758@sysman-doug.us.dell.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com>
            <20050815233849.GA3758@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1124160186_3269P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Aug 2005 22:43:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1124160186_3269P
Content-Type: text/plain; charset=us-ascii

On Mon, 15 Aug 2005 18:38:49 CDT, Doug Warzecha said:

> > If this is supposed to be used with the RBU code to trigger a BIOS  
> > update, ...
> 
> This driver is not needed by the RBU code.

Documentation/dell_rbu.txt says:

> The rbu driver needs to have an application which will inform the BIOS to
> enable the update in the next system reboot.

Can the dcdbas code be used to implement that application?



--==_Exmh_1124160186_3269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDAVK6cC3lWbTT17ARArAmAJ94nQ2CBxW3nkvXE9i7G9Jatb1UwQCgoPM6
fcD00PH7Ni/lMpezxTNBgwA=
=XEJG
-----END PGP SIGNATURE-----

--==_Exmh_1124160186_3269P--
