Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTALH4H>; Sun, 12 Jan 2003 02:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268257AbTALH4H>; Sun, 12 Jan 2003 02:56:07 -0500
Received: from h80ad2641.async.vt.edu ([128.173.38.65]:58241 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267328AbTALH4G>; Sun, 12 Jan 2003 02:56:06 -0500
Message-Id: <200301120804.h0C84jLE011563@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Mark Mielke <mark@mark.mielke.cc>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: inefficient RT vs efficient non-RT 
In-Reply-To: Your message of "Sun, 12 Jan 2003 02:58:44 EST."
             <20030112075844.GA16050@mark.mielke.cc> 
From: Valdis.Kletnieks@vt.edu
References: <20030112075844.GA16050@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-500163364P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jan 2003 03:04:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-500163364P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jan 2003 02:58:44 EST, Mark Mielke said:
> Think about it logically -- if I can process 5X as much data as you can on
> the same hardware, but I can't guarantee that *at* 5X no data will be lost,
> but then, I only run at 1X (the same speed as you), how many packets have
> a chance of being lost?

The question is, of course, whether you're willing to bet the entire
chemical plant on the chances of a packet being lost.

There's a difference between "if the core temperature hits 350
degrees, the pump WILL go on in 13 milliseconds" and "if the core temp
hits 350 degrees, the pump will have a 98% chance of going on sometime
between 13 and 17.5 milliseconds..."

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-500163364P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+ISGbcC3lWbTT17ARAvkZAKDbrKuP+OQOSp2avW1spLLBorI+RQCeJL4x
sm6WLPJxaRcqdt0+VBwlugo=
=Y4R/
-----END PGP SIGNATURE-----

--==_Exmh_-500163364P--
