Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268113AbTBMWLy>; Thu, 13 Feb 2003 17:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbTBMWLy>; Thu, 13 Feb 2003 17:11:54 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47492 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268113AbTBMWLw>; Thu, 13 Feb 2003 17:11:52 -0500
Message-Id: <200302132220.h1DMKtFT011682@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Paul Larson <plars@linuxtestproject.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
Subject: Re: 2.5.60 cheerleading... 
In-Reply-To: Your message of "Thu, 13 Feb 2003 15:57:56 CST."
             <1045173477.28494.66.camel@plars> 
From: Valdis.Kletnieks@vt.edu
References: <200302132154.h1DLs3ar012874@darkstar.example.net>
            <1045173477.28494.66.camel@plars>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1894142700P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Feb 2003 17:20:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1894142700P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Feb 2003 15:57:56 CST, Paul Larson said:

> Since Linus hasn't chimed in yet, I'm guessing that's exactly what
> happened.  I'm not trying to improve his workflow, but rather the
> workflow of anyone who might be interested in getting more involved in
> 2.5 testing.

What would help a lot of people (certainly me, at least), would be if
somebody kept a well-publicized "already known errata" list along with
(possibly unofficial) work-around patches.  Something along the line of:

compile fails in drivers/widget/fooby.c with error:
undefined structure member 'blat' in line 1149.
To fix:   apply <this patch>

On Thu, 13 Feb 2003 22:11:17 +0000 (GMT), John Bradford said:

> You can always use 2.5.X-BK1 to get the fixes that we would probably
> have been in 2.5.X if Linus had done more extensive testing on it
> before releasing it.

Almost but not quite what I meant - unless -BK1 is reserved for after-release
whoops and doesn't contain "new stuff for release N+1".   If -BK1 is only
bugfixes, that would be good.  
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech



--==_Exmh_1894142700P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TBpGcC3lWbTT17ARAm/RAJ4i0OPfUx720kj5DC3GDBMSBxIRtACfW60u
PIrt1YV3N6yGQ/3tntPnZ5Y=
=VPK0
-----END PGP SIGNATURE-----

--==_Exmh_1894142700P--
