Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTKKUb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTKKUbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:31:55 -0500
Received: from h80ad279a.async.vt.edu ([128.173.39.154]:1167 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263778AbTKKUby (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:31:54 -0500
Message-Id: <200311112031.hABKVlA8032501@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ?? 
In-Reply-To: Your message of "Tue, 11 Nov 2003 15:22:09 EST."
             <20031111202209.GB23283@delft.aura.cs.cmu.edu> 
From: Valdis.Kletnieks@vt.edu
References: <Qvw7.5Qf.9@gated-at.bofh.it> <QH4e.eV.3@gated-at.bofh.it> <3FB0EE0E.6090103@softhome.net> <20031111150256.GA13283@bitwizard.nl>
            <20031111202209.GB23283@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1781486417P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Nov 2003 15:31:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1781486417P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Nov 2003 15:22:09 EST, Jan Harkes <jaharkes@cs.cmu.edu>  said:

> Similarily, we might at some point be able to optimize sendfile between
> two sockets by pushing the connection off to a router somewhere in the
> network completely bypassing the local NIC.

Security can of worms there.. :)

--==_Exmh_1781486417P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/sUczcC3lWbTT17ARAjuWAKCDo9hC93RgQYUk+qEAw7Xi8BTsRwCeOOh0
rkYBuN7TP1Q2SJzgdmycEcQ=
=i6RH
-----END PGP SIGNATURE-----

--==_Exmh_1781486417P--
