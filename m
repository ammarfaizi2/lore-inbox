Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTH2NCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTH2NCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:02:50 -0400
Received: from h80ad263e.async.vt.edu ([128.173.38.62]:27276 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261170AbTH2NAz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:00:55 -0400
Message-Id: <200308291300.h7TD049n022785@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm3 
In-Reply-To: Your message of "Fri, 29 Aug 2003 11:54:27 +0200."
             <3F4F22D3.9080104@freemail.hu> 
From: Valdis.Kletnieks@vt.edu
References: <3F4F22D3.9080104@freemail.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1374096019P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Aug 2003 09:00:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1374096019P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Aug 2003 11:54:27 +0200, Boszormenyi Zoltan <zboszor@freemail.=
hu>  said:

> I tried to "make modules_install" on the compiled tree.
> It says:
> =

> # make modules_install
> Install a current version of module-init-tools
> See http://www.codemonkey.org.uk/post-halloween-2.5.txt
> make: *** [_modinst_] Error 1

Whoops... My fault. ;)

It was mostly a proof of concept - if there's a *known* better test I'm a=
ll ears. ;)

--==_Exmh_1374096019P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/T05TcC3lWbTT17ARAr/QAJ9lxu+yQwL70kXIihkwSDwgcK9RDgCg7eyU
TanvVJQxGj/KsPKPkwqhnK0=
=rCA6
-----END PGP SIGNATURE-----

--==_Exmh_1374096019P--
