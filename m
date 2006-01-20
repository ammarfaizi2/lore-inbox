Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWATTD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWATTD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWATTD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:03:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55258 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751116AbWATTD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:03:56 -0500
Message-Id: <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Michael Loftis <mloftis@wgops.com>
Cc: dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE? 
In-Reply-To: Your message of "Fri, 20 Jan 2006 10:31:12 MST."
             <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> 
From: Valdis.Kletnieks@vt.edu
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <43D10FF8.8090805@superbug.co.uk> <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com> <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
            <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137783832_3397P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 14:03:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137783832_3397P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Jan 2006 10:31:12 MST, Michael Loftis said:

> It's horrificly expensive to maintain large numbers of machines (even if 
> it's automated) as it is.  If you're doing embedded development too or 
> instead, it gets even harder when you need certain bugfixes or minor 
> changes, but end up having to redevelop things or start maintaining your 
> own kernel fork.

But you're perfectly happy to make the kernel developers do the equivalent thing
when they have to maintain 2 forks (a stable and devel).  Go back and look at
the status of the 2.5 tree - there were *large* chunks of time when 2.4 or 2.5
would get an important bugfix, but the other tree wouldn't get it for *weeks*
because of the hassle of cross-porting the patch.

--==_Exmh_1137783832_3397P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD0TQYcC3lWbTT17ARAlIIAJ9DhuqSaiX9tCMFpsgyFo2wiCM9UQCfTWBY
BElZslMqHyB9i0Fa6+dt/ug=
=Mzhw
-----END PGP SIGNATURE-----

--==_Exmh_1137783832_3397P--
