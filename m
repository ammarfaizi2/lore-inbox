Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTKPSiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTKPSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 13:38:52 -0500
Received: from h80ad26be.async.vt.edu ([128.173.38.190]:46476 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263166AbTKPSiu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 13:38:50 -0500
Message-Id: <200311161838.hAGIciLa030513@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431" 
In-Reply-To: Your message of "Sun, 16 Nov 2003 18:40:12 +0100."
             <20031116184012.5d9f4c12.skraw@ithnet.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031116130558.GB199@elf.ucw.cz> <20031116170509.GB201@elf.ucw.cz> <200311161727.hAGHRbLa028984@turing-police.cc.vt.edu>
            <20031116184012.5d9f4c12.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2104043516P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Nov 2003 13:38:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2104043516P
Content-Type: text/plain; charset=us-ascii

On Sun, 16 Nov 2003 18:40:12 +0100, Stephan von Krawczynski said:

> There is quite a simple difference in -XX kernel and a distro-patch. People
> have to actively decide to use some patched kernel for whatever their reason
> may be. A distro on the other hand floods the average user with patched
> versions _without_ the users' active decision.

Take it the other direction - people *also* actively choose a distro based
on some reason (to be honest, a major reason I ended up in RedHat/Fedora
rather than some other Linux distro or even a *bsd was because at the time
I needed a *nix with an X server that supported the i810 chipset, they were
the only ones shipping one pre-built).

On the flip side, I freely admit that the vast majority of things Andrew
puts in his kernel basically get flooded to me, because installing the
entire -mm patch is a lot easier than installing half of it....

--==_Exmh_2104043516P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/t8Q0cC3lWbTT17ARAoOMAJ9TcbzE4CqLbqgcxlL0AXcLUsBahgCg/pHH
ruheD2qPuGHFgWo8PcGMJuU=
=dhHM
-----END PGP SIGNATURE-----

--==_Exmh_2104043516P--
