Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUAWEMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 23:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUAWEMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 23:12:38 -0500
Received: from h80ad2532.async.vt.edu ([128.173.37.50]:62592 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266508AbUAWEMc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 23:12:32 -0500
Message-Id: <200401222154.i0MLsRAq002802@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization 
In-Reply-To: Your message of "Wed, 21 Jan 2004 14:35:07 EST."
             <200401211935.i0LJZ7Qd003905@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20040120000535.7fb8e683.akpm@osdl.org> <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro> <20040121154627.GB10508@lsc.hu> <200401211659.i0LGxqHX002960@turing-police.cc.vt.edu> <20040121105836.526c943b.akpm@osdl.org>
            <200401211935.i0LJZ7Qd003905@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_687264002P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Jan 2004 16:54:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_687264002P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Jan 2004 14:35:07 EST, Valdis.Kletnieks@vt.edu said:

> > > > > > CONFIG_IPV6_PRIVACY=y

> 2.6.1-mm4 worked, 2.6.1-mm5 failed, haven't tried 2.6.2-rc1 (will do so this 
evening).

Just to follow up, 2.6.2-rc1-mm1 boots fine with IPV6_PRIVACY defined.

--==_Exmh_687264002P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAEEaTcC3lWbTT17ARAj5uAKC90k/vFV5Lw6qZANMcprjC1fWFyACdEIL9
j0IS9mucdMDUPjiIWXNuS8A=
=WvBy
-----END PGP SIGNATURE-----

--==_Exmh_687264002P--
