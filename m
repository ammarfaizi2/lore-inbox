Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTJ3Edi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 23:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJ3Edi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 23:33:38 -0500
Received: from h80ad26bd.async.vt.edu ([128.173.38.189]:64389 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262126AbTJ3Edh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 23:33:37 -0500
Message-Id: <200310300433.h9U4X49X010982@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Bug somewhere in crypto or ipsec stuff 
In-Reply-To: Your message of "Thu, 30 Oct 2003 12:41:24 +0900."
             <20031030.124124.26191552.yoshfuji@linux-ipv6.org> 
From: Valdis.Kletnieks@vt.edu
References: <20031030.121732.12858700.yoshfuji@linux-ipv6.org> <Xine.LNX.4.44.0310292221320.23405-100000@thoron.boston.redhat.com>
            <20031030.124124.26191552.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1784525846P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Oct 2003 23:33:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1784525846P
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Oct 2003 12:41:24 +0900, YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= said:

> Well, people may want to get just any algorithm.
> In such case,
>  - crypto allows name == NULL, and return any algorithm
>    (for example, an algorithm that we see first.)

This could be embarasssing if somebody happened to have the rot13 debugging
algorithm loaded.....

--==_Exmh_-1784525846P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/oJR/cC3lWbTT17ARAlPEAKCjUMEEZAQSkrLUBgHwAelA+d/xOQCdF76k
qjzL1sHOGwz+5yOIN0nGoNo=
=x8w/
-----END PGP SIGNATURE-----

--==_Exmh_-1784525846P--
