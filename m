Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTFBW5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 18:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTFBW5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 18:57:06 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4483 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264198AbTFBW5F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 18:57:05 -0400
Message-Id: <200306022310.h52NAJSH009806@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andreas Boman <aboman@nerdfest.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees. 
In-Reply-To: Your message of "Mon, 02 Jun 2003 16:53:48 EDT."
             <1054587227.7683.92.camel@asgaard.midgaard.us> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0306020927420.2970-100000@localhost.localdomain>
            <1054587227.7683.92.camel@asgaard.midgaard.us>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1111986745P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jun 2003 19:10:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1111986745P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Jun 2003 16:53:48 EDT, Andreas Boman said:
> playing. renicing -5 <pid of xmms>, or 5 <pid of mozilla> 'solves' the
> issue. Ofcourse, if mozilla is the reniced process, xmms may still skip
> when switching desktops, again that is much more likely to occur during

Just as another datapoint, my Dell Latitude C840 would do the 'xmms skips
on desktop switch' fairly regularly under 2.5.69 and 2.5.70.  It's gotten
a lot more rock-solid in 2.5.70-mm3.

--==_Exmh_-1111986745P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD4DBQE+29lacC3lWbTT17ARAjMtAJiJwVe0mOEA4lsfwrSYqkrcpZJ7AJwIHYSR
o39g2FDradOYdJmcC+iyxg==
=90gX
-----END PGP SIGNATURE-----

--==_Exmh_-1111986745P--
