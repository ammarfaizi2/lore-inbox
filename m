Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTCQFkW>; Mon, 17 Mar 2003 00:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbTCQFkW>; Mon, 17 Mar 2003 00:40:22 -0500
Received: from h80ad2477.async.vt.edu ([128.173.36.119]:43905 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262796AbTCQFkV>; Mon, 17 Mar 2003 00:40:21 -0500
Message-Id: <200303170551.h2H5p0Oo002258@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.2 03/12/2003 with nmh-1.0.4+dev
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update filesystems config. menu 
In-Reply-To: Your message of "Sat, 15 Mar 2003 13:31:59 PST."
             <34070.4.64.238.61.1047763919.squirrel@www.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <200303150920.h2F9KGm16328@mako.theneteffect.com> <1047720287.3505.146.camel@workshop.saharact.lan> <33707.4.64.238.61.1047748124.squirrel@www.osdl.org> <20030315211151.40f1cf84.azarah@gentoo.org>
            <34070.4.64.238.61.1047763919.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_247936494P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Mar 2003 00:50:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_247936494P
Content-Type: text/plain; charset=us-ascii

On Sat, 15 Mar 2003 13:31:59 PST, "Randy.Dunlap" said:

> Yes, I'd say so, although the message could say something like:
>   Kernel does not include a filesystem for / on this computer.
> And would it also have to check the capabilities of what's in the
> initrd?  (not that I'm advocating any of this)

Well... the only time *I*'ve screwed it up was building with ext3 only,
having all ext3 filesystems on the disk, and watching Bad And Ugly things
happen when the ext2-format initrd tried to mount...

--==_Exmh_247936494P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+dWJDcC3lWbTT17ARAsQHAJ4xrmcT9IAQPjZjWRMIqEUGqi0MBQCgiJnH
dXufrrqjBEAmzh4sGSYsmCA=
=eoBD
-----END PGP SIGNATURE-----

--==_Exmh_247936494P--
