Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTAKBcd>; Fri, 10 Jan 2003 20:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTAKBcd>; Fri, 10 Jan 2003 20:32:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10371 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267024AbTAKBcc>; Fri, 10 Jan 2003 20:32:32 -0500
Message-Id: <200301110141.h0B1f9LK017119@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NGPT 2.2.0 RELEASED: TOPS LINUXTHREADS AND NPTL IN SCALABILITY AND PERFORMANCE 
In-Reply-To: Your message of "Fri, 10 Jan 2003 20:33:46 EST."
             <20030111013346.GB25649@gtf.org> 
From: Valdis.Kletnieks@vt.edu
References: <OFD6D876A7.7D7E3A46-ON85256CAA.0068C7D5@us.ibm.com> <200301110203.09346.m.c.p@gmx.net> <3E1F72D7.7050505@lexus.com>
            <20030111013346.GB25649@gtf.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1139781780P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 20:41:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1139781780P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 20:33:46 EST, Jeff Garzik said:
> On Fri, Jan 10, 2003 at 05:26:47PM -0800, jjs wrote:
> > But according to my understanding, a more accurate
> > measure of nptl performance would require a current
> > glibc, with the nptl-specific enhancements -
> > 
> > or am I missing something here?
> 
> You are correct:  you need a recent 2.5 kernel and a recent glibc.

I'll bite - how recent a glibc?  Does the 2.3.1 RPM that RedHat included
on the Phoebe beta qualify, or do we need even more bleeding-edge?


--==_Exmh_-1139781780P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+H3Y0cC3lWbTT17ARAscmAJ9ZfSM6QxnLcUaew0yF9KEDj2EjlgCgjd9E
GJgBgU8l8vaNPfHyrVLD570=
=9yPu
-----END PGP SIGNATURE-----

--==_Exmh_-1139781780P--
