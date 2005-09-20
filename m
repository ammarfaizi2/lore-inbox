Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVITUQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVITUQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVITUQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 16:16:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17824 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964788AbVITUQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 16:16:50 -0400
Message-Id: <200509202015.j8KKFfjd025051@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Roman I Khimov <rik@osrc.info>
Cc: reiserfs-list@namesys.com, Pavel Machek <pavel@suse.cz>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Your message of "Tue, 20 Sep 2005 23:28:12 +0400."
             <200509202328.28501.rik@osrc.info> 
From: Valdis.Kletnieks@vt.edu
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432E5024.20709@namesys.com> <20050920075133.GB4074@elf.ucw.cz>
            <200509202328.28501.rik@osrc.info>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127247340_3303P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 16:15:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127247340_3303P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Sep 2005 23:28:12 +0400, Roman I Khimov said:
> --nextPart1692600.LIfSYN1P7A

> Maybe I'm doing something wrong here, but ext2 have failed on second check
> of first pass with
> 
> Second check...
> e2fsck 1.34 (25-Jul-2003)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure

> fsck.damaged: ***** FILE SYSTEM WAS MODIFIED *****
> fsck.damaged: 1345/25064 files (1.7% non-contiguous), 94063/100000 blocks
> fsck lied about its success (result = 1)

What was the return value and output from the *first* fsck? 

--==_Exmh_1127247340_3303P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMG3scC3lWbTT17ARAgi/AJ4+c08JP/YQ4aTEUZ5KGu5fCoESJgCcDsqK
mkXM4iAivzZ62vURlj2Ahq8=
=6cVH
-----END PGP SIGNATURE-----

--==_Exmh_1127247340_3303P--
