Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbTGLGAM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTGLGAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:00:12 -0400
Received: from h80ad26c8.async.vt.edu ([128.173.38.200]:53888 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267563AbTGLGAI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:00:08 -0400
Message-Id: <200307120614.h6C6EhSe019742@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: Bug in open() function (?) 
In-Reply-To: Your message of "Fri, 11 Jul 2003 22:23:00 PDT."
             <20030711222300.7627a811.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com> <20030712024216.GA399@bouh.unh.edu> <200307112309.08542.jcwren@jcwren.com> <20030711203809.3c320823.akpm@osdl.org> <200307120511.h6C5BCSe017963@turing-police.cc.vt.edu>
            <20030711222300.7627a811.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1141298553P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Jul 2003 02:14:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1141298553P
Content-Type: text/plain; charset=us-ascii

On Fri, 11 Jul 2003 22:23:00 PDT, Andrew Morton said:

> We've lived with it for this long.

Well... you have a point there..

> Given that the behaviour is undefined, the behaviour which we should
> implement is clearly "whatever 2.4 is doing".  So let's leave it alone.

I suppose I could live with that *IF* somebody fixes 'man 2 open' to
reflect reality.




--==_Exmh_1141298553P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/D6dTcC3lWbTT17ARAibEAJ9EBPm6XwXM0rXzhI9xt7aGjhNUfQCfWa/b
v30sikSXCCICNePAFBXLJu0=
=LffA
-----END PGP SIGNATURE-----

--==_Exmh_1141298553P--
