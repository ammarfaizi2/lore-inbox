Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVEBPyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVEBPyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 11:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVEBPyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 11:54:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:27405 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261346AbVEBPy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 11:54:26 -0400
Message-Id: <200505021553.j42FrIQV007494@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove BK documentation 
In-Reply-To: Your message of "Sun, 01 May 2005 20:16:16 EDT."
             <42757150.3060309@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050501233441.GC3592@stusta.de> <20050501234331.GA9244@havoc.gtf.org> <20050502000845.GE3592@stusta.de>
            <42757150.3060309@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115049198_5213P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 May 2005 11:53:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115049198_5213P
Content-Type: text/plain; charset=us-ascii

On Sun, 01 May 2005 20:16:16 EDT, Jeff Garzik said:
> Adrian Bunk wrote:

> > I'd have done this if you were listed as author in any of the files.
> 
> Look at the changelog or file revision history...

The few times I've submitted patches I've been lucky and MAINTAINERS pointed
the cc: in the right direction(s) (or at least close enough).

It might be useful to document, for somebody who has just a Linus -rc or
an Andrew -mm kernel source tree, what magic incantations need to be done
to query the changelog or file revision history for that sort of info.
Pulling multiple release Changelogs from www.kernel.org and doing a binary search
isn't the most fun thing in the world (especially because sometimes the
Changelog entry just says "add documentation about Foo" so a search for
Documentation/foo.txt misses...)

--==_Exmh_1115049198_5213P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCdkzucC3lWbTT17ARAuoMAJ9H4twyMiUHszdXI9txC10eQH2ucwCg5nEF
5W4Kz7dvbvM04Jb+aCo4D+A=
=HlIW
-----END PGP SIGNATURE-----

--==_Exmh_1115049198_5213P--
