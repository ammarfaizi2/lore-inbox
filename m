Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUE0ThI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUE0ThI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUE0ThI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:37:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61575 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265122AbUE0TgN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:36:13 -0400
Message-Id: <200405271931.i4RJVjYB002642@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org
Subject: CVS tags (was  Re: [Prism54-devel] Re: [PATCH 4/14 linux-2.6.7-rc1] prism54: add support for avs header in 
In-Reply-To: Your message of "Thu, 27 May 2004 15:16:49 EDT."
             <20040527191649.GT3330@ruslug.rutgers.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20040524083146.GE3330@ruslug.rutgers.edu> <40B631B3.4000902@pobox.com>
            <20040527191649.GT3330@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2099624870P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 May 2004 15:31:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2099624870P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 May 2004 15:16:49 EDT, Luis R. Rodriguez said:
> --- ksrc/islpci_eth.c
> +++ ksrc-new/islpci_eth.c

I think this was what he referred to:

>-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03 15:27:44 ajfa Exp $
>+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/19 23:03:58 ajfa Exp $

as this will almost surely cause rejects (sooner or later) unless 100% of your
patches are applied and in the right order.


--==_Exmh_-2099624870P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAtkIhcC3lWbTT17ARAmntAJ0cQORS1Mv5p7jxtoH94Unmt1tNRwCg5W7z
qg0Ucv7Kzj2Nyz7+R6ecl/Y=
=3CU7
-----END PGP SIGNATURE-----

--==_Exmh_-2099624870P--
