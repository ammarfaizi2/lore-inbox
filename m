Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVEMV0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVEMV0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVEMV0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:26:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:49417 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261465AbVEMVXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:23:21 -0400
Message-Id: <200505132122.j4DLMRdU027493@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chris Friesen <cfriesen@nortel.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-os@analogic.com,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day 
In-Reply-To: Your message of "Fri, 13 May 2005 15:07:04 MDT."
             <428516F8.20100@nortel.com> 
From: Valdis.Kletnieks@vt.edu
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in> <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com> <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com> <42850FC7.7010603@tmr.com> <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
            <428516F8.20100@nortel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116019347_4705P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 May 2005 17:22:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116019347_4705P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 May 2005 15:07:04 MDT, Chris Friesen said:

> Because that's what the maximum negative number gives?

Good, somebody's paying attention.   :)

So what breaks if we change it to an 'unsigned int', and can we fix those
issues before 2038, and will any of us here now *care* when an unsigned 32-bit
overflows in 2106 or whenever it is? :)



--==_Exmh_1116019347_4705P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFChRqScC3lWbTT17ARAlZyAKCLQjks5MCiAnDSuHvkXc4qjpV29wCgmb6Y
w/PYh/rZ6G6FMcXurMOV9AI=
=G1Lh
-----END PGP SIGNATURE-----

--==_Exmh_1116019347_4705P--
