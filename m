Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbTJRXMq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTJRXMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:12:46 -0400
Received: from h80ad252e.async.vt.edu ([128.173.37.46]:3456 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261943AbTJRXMm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:12:42 -0400
Message-Id: <200310182307.h9IN7DLP001337@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Christophe Saout <christophe@saout.de>, Walt H <waltabbyh@comcast.net>,
       arekm@pld-linux.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] initrd with devfs enabled (Re: initrd and 2.6.0-test8) 
In-Reply-To: Your message of "Sat, 18 Oct 2003 20:41:48 BST."
             <20031018194148.GE7665@parcelfarce.linux.theplanet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <3F916A0C.10800@comcast.net> <20031018175236.GA7665@parcelfarce.linux.theplanet.co.uk> <1066501993.4208.6.camel@chtephan.cs.pocnet.net>
            <20031018194148.GE7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_572306464P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 18 Oct 2003 19:07:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_572306464P
Content-Type: text/plain; charset=us-ascii

On Sat, 18 Oct 2003 20:41:48 BST, viro@parcelfarce.linux.theplanet.co.uk said:

> diff -urN B8/init/do_mounts_initrd.c B8-current/init/do_mounts_initrd.c
> --- B8/init/do_mounts_initrd.c	Sat Oct 18 13:09:57 2003
> +++ B8-current/init/do_mounts_initrd.c	Sat Oct 18 15:26:58 2003
> @@ -109,12 +109,12 @@

Cornfirmed this fixes my problems with RD0-initrd patch.  System now boots with devfs.

--==_Exmh_572306464P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/kcegcC3lWbTT17ARAnVPAKDvhbKRIGJXJcx+r1L6bf1f1oGHaACcCoH8
HgDBvVoO+T/J6INHX4rs6CI=
=risK
-----END PGP SIGNATURE-----

--==_Exmh_572306464P--
