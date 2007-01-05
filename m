Return-Path: <linux-kernel-owner+w=401wt.eu-S1422652AbXAERr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbXAERr3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbXAERr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:47:27 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47806 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422647AbXAERr0 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:47:26 -0500
Message-Id: <200701051747.l05HlOpX010735@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how can we use assert in non-debug version kernel ?
In-Reply-To: Your message of "Fri, 05 Jan 2007 05:39:19 GMT."
             <20070105053919.75196.qmail@web7703.mail.in.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20070105053919.75196.qmail@web7703.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168019244_3135P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Jan 2007 12:47:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168019244_3135P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 Jan 2007 05:39:19 GMT, Seetharam Dharmosoth said:

> can you please give me hint that -
>  "how can we use assert in non-debug version kernel ?"

BUG_ON(your_condition_here);

may be what you're looking for?

--==_Exmh_1168019244_3135P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFno8scC3lWbTT17ARAmLsAKDmg9dX5CERKAvQGXRszGQx/G5EXwCeKM1R
xf0sZgye5QcBVaWW9otrucY=
=W4o1
-----END PGP SIGNATURE-----

--==_Exmh_1168019244_3135P--
