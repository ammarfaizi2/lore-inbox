Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947110AbWKKGbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947110AbWKKGbs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 01:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947109AbWKKGbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 01:31:47 -0500
Received: from pool-72-66-197-94.ronkva.east.verizon.net ([72.66.197.94]:21443
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1947110AbWKKGbr (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 01:31:47 -0500
Message-Id: <200611110631.kAB6V12n011990@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Al Boldi <a1426z@gawab.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
In-Reply-To: Your message of "Sat, 11 Nov 2006 07:15:49 +0300."
             <200611110715.49343.a1426z@gawab.com>
From: Valdis.Kletnieks@vt.edu
References: <200611090757.48744.a1426z@gawab.com> <200611110022.52304.a1426z@gawab.com> <20061110133101.4e6cddd3@freekitty>
            <200611110715.49343.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163226660_6400P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Nov 2006 01:31:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163226660_6400P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Nov 2006 07:15:49 +0300, Al Boldi said:
> I don't think there is a lack of heuristics, nor is there a lack of 
> discussion.  What is needed, is a realization of the problem.
> 
> IOW, respective tree-owners need to come to a realization of the state of 
> their trees, problem or not.  If it has a problem, that problem needs to be 
> fixed or backed out of stable and moved into dev.

I keep trying to parse this, and it keeps coming up as "content-free".

For starters, you don't even have a useful definition of "has a problem".
There's a whole *range* of definitions for that, and even skilled and
respected members of the Linux kernel community can disagree about whether
something is "a problem".  For example, see the thread about a week ago
about "Remove hotplug cpu crap from cpufreq".

If, given a *specific* feature with high wart quotient, we can't agree on
whether it needs to be fixed or backed out, we're doomed to fail if we
start handwaving about problems "in general".  As a group, we suck at
anything that isn't specific, like "Algorithm A is better than B for
case XYZ".

--==_Exmh_1163226660_6400P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFVW4kcC3lWbTT17ARAvI+AJ9hTL7KOGHfj128ppvfvVwqhhftggCgizzu
/wAX53bwSMPRBL1N3THdesY=
=DGmc
-----END PGP SIGNATURE-----

--==_Exmh_1163226660_6400P--
