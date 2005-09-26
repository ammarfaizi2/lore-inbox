Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbVIZQZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbVIZQZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbVIZQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:25:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7887 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751660AbVIZQZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:25:41 -0400
Message-Id: <200509261625.j8QGPQ9K007078@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: dmitry pervushin <dpervushin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: SPI 
In-Reply-To: Your message of "Mon, 26 Sep 2005 15:12:14 +0400."
             <1127733134.7577.0.camel@diimka.dev.rtsoft.ru> 
From: Valdis.Kletnieks@vt.edu
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127751926_3790P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Sep 2005 12:25:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127751926_3790P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Sep 2005 15:12:14 +0400, dmitry pervushin said:
> Hello guys,
> 
> I am attaching the next incarnation of SPI core; feel free to comment it.

> +/* The devfs code is contributed by Philipp Matthias Hahn 
> +   <pmhahn@titan.lahn.de> */

> +/* devfs code corrected to support automatic device addition/deletion
> +   by Vitaly Wool <vwool@ru.mvista.com> (C) 2004 MontaVista Software, Inc. 
> + */

I'd like to thank Vitaly and Philipp for their work, which was probably useful
at the time, but I've always wondered - when cleaning up code, should such comments
be removed too, or left as historical reminders?  The MAINTAINERS file seems
to get cleaned most of the time, the CREDITS doesn't - which way should
in-source comments go?


--==_Exmh_1127751926_3790P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDOCD1cC3lWbTT17ARAuayAJ9zG+ZqahDOxDuVAyMCsslnD79Q5ACgz4ce
ExBRqnT/uUB+QbRKYNiGTxs=
=Mutr
-----END PGP SIGNATURE-----

--==_Exmh_1127751926_3790P--
