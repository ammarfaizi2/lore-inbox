Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTEVOeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTEVOeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:34:11 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26496 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261904AbTEVOeK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:34:10 -0400
Message-Id: <200305221447.h4MElAKx003511@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: web page on O(1) scheduler 
In-Reply-To: Your message of "Thu, 22 May 2003 07:52:44 +0200."
             <5.2.0.9.2.20030522063421.00cc3e90@pop.gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net> <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
            <5.2.0.9.2.20030522063421.00cc3e90@pop.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-95293826P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 May 2003 10:47:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-95293826P
Content-Type: text/plain; charset=us-ascii

On Thu, 22 May 2003 07:52:44 +0200, Mike Galbraith said:

> It does consider cpu usage though.  Your run history is right there in your 
> accumulated sleep_avg.  Unfortunately (in some ways, fortunate in others.. 
> conflict) that information can be diluted down to nothing instantly by new 
> input from one wakeup.

Maybe there should be a scheduler tunable that says how much it should be
diluted?

--==_Exmh_-95293826P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+zOLucC3lWbTT17ARArwdAJ4qBW9quX9fmz09kQsZs99EeJ7h+gCg2jsZ
TuQ1EIowRA1fe4v1rxX9XTE=
=SjTf
-----END PGP SIGNATURE-----

--==_Exmh_-95293826P--
