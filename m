Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTDQRpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDQRpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:45:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:27776 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261816AbTDQRpB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:45:01 -0400
Message-Id: <200304171756.h3HHuqb9006030@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67 
In-Reply-To: Your message of "Thu, 17 Apr 2003 19:46:34 +0200."
             <1050601594.1073.1.camel@krycek> 
From: Valdis.Kletnieks@vt.edu
References: <018401c30505$1a1e6200$6400a8c0@witbe>
            <1050601594.1073.1.camel@krycek>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1652211265P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Apr 2003 13:56:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1652211265P
Content-Type: text/plain; charset=us-ascii

On Thu, 17 Apr 2003 19:46:34 +0200, Mads Christensen <mfc@krycek.org>  said:

> You have to get
> CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y
> inorder for you to see anything =)

OK.. Can we *please* fix the 2.5.68 Kconfig to default these 3 values
so we don't have to keep saying this?  The embedded people that want
'n' or 'm' can type it themselves. ;)

--==_Exmh_1652211265P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+nurjcC3lWbTT17ARAqesAKC7j/ZHz8WcIMrDNNuRAwFSvNyxzACcC32x
4REkSFASC4RAcJgkQebOoPw=
=+en+
-----END PGP SIGNATURE-----

--==_Exmh_1652211265P--
