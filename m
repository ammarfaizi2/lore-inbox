Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWJRT6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWJRT6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWJRT6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:58:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60847 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030277AbWJRT6A (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:58:00 -0400
Message-Id: <200610181957.k9IJvw4m013149@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 w/ GPS time source: worse performance
In-Reply-To: Your message of "Wed, 18 Oct 2006 18:44:59 +0200."
             <45365A0B.5030306@xs4all.nl>
From: Valdis.Kletnieks@vt.edu
References: <4534F5F7.8020003@xs4all.nl> <1161103616.2919.70.camel@mindpipe> <45364631.9070805@xs4all.nl> <1161189384.15860.85.camel@mindpipe>
            <45365A0B.5030306@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1161201478_4027P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 15:57:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1161201478_4027P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 Oct 2006 18:44:59 +0200, Udo van den Heuvel said:
> 
> It is stuff that is visible by watching ntpq -pn output, by letting mrtg
> graph stuff, etc. Watch the offset and jitter collumns.
> Check /usr/sbin/ntpdc -c kerninfo output. Graph that stuff.

So... you've presumably done that while identifying there is an issue.
Please share the results.  Have you tried booting back into a 2.6.17
or so and seen offset/jitter improve?  etc etc etc.

--==_Exmh_1161201478_4027P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFNodGcC3lWbTT17ARAuIbAJ9FlbACZzYp/bpHwlrcAbcXXS210ACgoK9y
MremA5C7bStrY+C/fFXOrEI=
=bhEE
-----END PGP SIGNATURE-----

--==_Exmh_1161201478_4027P--
