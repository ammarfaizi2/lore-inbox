Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTDXFo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTDXFo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:44:56 -0400
Received: from h80ad2785.async.vt.edu ([128.173.39.133]:63104 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264430AbTDXFoz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:44:55 -0400
Message-Id: <200304240556.h3O5uexQ002672@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp! 
In-Reply-To: Your message of "Thu, 24 Apr 2003 06:39:50 BST."
             <20030424053950.GV10374@parcelfarce.linux.theplanet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0304232146020.19326-100000@home.transmeta.com> <3EA76FFE.5070007@tequila.co.jp>
            <20030424053950.GV10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_695431504P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Apr 2003 01:56:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_695431504P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Apr 2003 06:39:50 BST, viro@parcelfarce.linux.theplanet.co.uk said:

> Excuse me, but I don't get the last part.  You know that
> 	F had been built in environment of unspecified degree of security
> 	from source that had been kept in <--->
> 	written by programmers you don't know
> 	who had been hired in conformace with criteria <--->
> 	and released after passing QA of unknown quality (but you can bet
> that they had missed some security holes in the past)
> 	under a license that almost certainly disclaims any responsibility.
> 
> Care to explain how does one get from the trust in above to "trusted to run"?

On top of which, if a buffer overflow is found, the exploit will run in
the context of the signed program.  What it *does* mean is that once the
ankle-biting script kiddie breaks in, the kernel will hopefully refuse to
run their unsigned exploits.

--==_Exmh_695431504P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+p3yYcC3lWbTT17ARAmRqAJ0aaN8xjzdZGDzPJzJvfkvSzurq+QCg2Vao
GMeoAbMQygYKsozR3Cn5K7A=
=zLPd
-----END PGP SIGNATURE-----

--==_Exmh_695431504P--
