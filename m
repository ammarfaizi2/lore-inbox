Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTHGQY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270326AbTHGQY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:24:29 -0400
Received: from h80ad277d.async.vt.edu ([128.173.39.125]:31360 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270237AbTHGQYX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:24:23 -0400
Message-Id: <200308071624.h77GOEPp005647@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Themel <themel@iwoars.net>, linux-kernel@vger.kernel.org
Subject: Re: Device-backed loop broken in 2.6.0-test2? 
In-Reply-To: Your message of "Thu, 07 Aug 2003 12:07:32 EDT."
             <200308071607.h77G7WPp005392@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20030806224022.GA3741@iwoars.net> <20030806174043.27fd674a.akpm@osdl.org>
            <200308071607.h77G7WPp005392@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1652095302P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Aug 2003 12:24:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1652095302P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Aug 2003 12:07:32 EDT, Valdis.Kletnieks@vt.edu said:

> /Valdis (who is off to apply the patch that Andrew attached, which doesn't appear to
> be in -mm5)...

Passing curious.. the first 3 hunks of the patch aren't in -mm5, the last 2 (or
variants thereof) are.... of course I hit 'send' before checking past the first
3 hunks.. ;)

Are the first 3 superfluous, or did -mm5 get half a patch?


--==_Exmh_1652095302P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Mn0tcC3lWbTT17ARAlyJAKC5WP4WBzCSajzFDM3RiBLHBsPwWwCfS9Tw
pBSYFZeiZTK6ASkCS1yBZa8=
=BnqV
-----END PGP SIGNATURE-----

--==_Exmh_1652095302P--
