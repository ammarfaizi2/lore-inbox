Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S262711AbUKEQEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUKEQEv (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 5 Nov 2004 11:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbUKEQEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:04:50 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12160 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261153AbUKEQEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:04:20 -0500
Message-Id: <200411050433.iA54XBGq004923@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, mailinglisten@hentges.net
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working 
In-Reply-To: Your message of "Thu, 04 Nov 2004 13:15:13 +0100."
             <418A1D51.4010504@free.fr> 
From: Valdis.Kletnieks@vt.edu
References: <418A1D51.4010504@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_494204241P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Nov 2004 23:33:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_494204241P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Nov 2004 13:15:13 +0100, matthieu castet said:

> Could you try these 2 patchs with CONFIG_PNPACPI=y ?

>  filename="pnpacpi.patch"

>  filename="i8042_pnp.patch"

Just confirming that my Dell Latitude C840 had the same "no keyboard"
issues with -rc1-mm2, and these 2 patches result in a working keyboard
with CONFIG_PNPACPI.

--==_Exmh_494204241P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiwKHcC3lWbTT17ARAhNvAKDFmqk/MHPQWRzyBfNsQnhrqjYcuACg/FnY
ACi06BCkgzinmrbdKOR7soc=
=XUoY
-----END PGP SIGNATURE-----

--==_Exmh_494204241P--
