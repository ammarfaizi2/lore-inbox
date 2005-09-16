Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVIPVL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVIPVL2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVIPVL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 17:11:28 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54501 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751290AbVIPVL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 17:11:28 -0400
Message-Id: <200509162111.j8GLBM6e020186@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Trilight <trilight@ns666.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell laptops crashing / 2.6.13+ ? 
In-Reply-To: Your message of "Fri, 16 Sep 2005 22:23:39 +0200."
             <432B29CB.5090407@ns666.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050916221000.GA3454@abhays.us.dell.com>
            <432B29CB.5090407@ns666.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126905082_3550P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Sep 2005 17:11:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126905082_3550P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Sep 2005 22:23:39 +0200, Trilight said:

> I was wondering if any one else has a dell laptop which crashes during
> boot or locks up with 2.6.13 and higher ? Especially Oopses

Hmm... I'm on 2.6.13-mm1 on a Dell Latitude C840 here, and it seems relatively
stable modulo the occasional lockup due to the NVidia card/driver (but of course,
that's my problem, not lkml's).

What model laptop *exactly*, and do you have the text of an oops?

--==_Exmh_1126905082_3550P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDKzT6cC3lWbTT17ARAmtbAKDQZsW69kDvwg6kZTDXgJl+g1VKuwCfQhYV
xX+nXoUluIqP3A2vUpnaBYk=
=QAQi
-----END PGP SIGNATURE-----

--==_Exmh_1126905082_3550P--
