Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTELOvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTELOvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:51:38 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11137 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262195AbTELOvg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:51:36 -0400
Message-Id: <200305121504.h4CF4EJ5007017@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel? 
In-Reply-To: Your message of "Mon, 12 May 2003 04:59:29 PDT."
             <20030512045929.C29781@google.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030512045929.C29781@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2024354380P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 May 2003 11:04:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2024354380P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 May 2003 04:59:29 PDT, Frank Cusack <fcusack@fcusack.com>  said:
> I've written a public domain implementation, which I'd be willing to
> relicense under GPL (although I don't see the point), but in any case

Well.. there's a very good reason to relicense under GPL, or BSD, or X11-style.

And that's to cover your ass from being sued.

If you release it as "public domain", you waive *all* rights to it, including:

1) The right to prohibit or control what people do with it, including taking
it private and closed and making lots of money off it and basically ripping
you off.

2) You can't attach a "hold harmless" clause to it.  So if you put it in
the public domain, since you don't have copyright on it anymore, you can't
say "as a condition of copying, you promise not to sue me if this software
turns your hair green".

The second is pretty important - although we all complain about large vendors
disclaiming all responsibility and liability for their bugs, that's something
you *REALLY* want to try to do if you're a open-source programmer....

Of course, IANAL, so consult one if you're worried. ;)

--==_Exmh_-2024354380P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+v7ftcC3lWbTT17ARAnE0AJ9w85RDzFDxq7gGglNdcZcifJvWKACggCaw
JhuSnJ4F0wamEBYC8VkcaVs=
=6g3r
-----END PGP SIGNATURE-----

--==_Exmh_-2024354380P--
