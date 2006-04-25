Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWDYVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWDYVDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDYVDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:03:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6873 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932306AbWDYVDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:03:01 -0400
Message-Id: <200604252102.k3PL2iQJ013299@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Avi Kivity <avi@argo.co.il>
Cc: Bongani Hlope <bhlope@mweb.co.za>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules 
In-Reply-To: Your message of "Tue, 25 Apr 2006 23:26:17 +0300."
             <444E85E9.70300@argo.co.il> 
From: Valdis.Kletnieks@vt.edu
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <200604252211.52474.bhlope@mweb.co.za>
            <444E85E9.70300@argo.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145998964_2618P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2006 17:02:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145998964_2618P
Content-Type: text/plain; charset=us-ascii

On Tue, 25 Apr 2006 23:26:17 +0300, Avi Kivity said:

> auto_ptr<>'s are fully inlined so their impact is nil.

Except for the punishment the i-cache takes.  There's reasons why we
fight over "to inline or not to inline"....

--==_Exmh_1145998964_2618P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFETo50cC3lWbTT17ARAod+AKD3BDhMZbkv86nBF+TuaGb7wjGB/wCePJd6
catZYx7ci2KiLI6itfgdZhs=
=Vvjj
-----END PGP SIGNATURE-----

--==_Exmh_1145998964_2618P--
