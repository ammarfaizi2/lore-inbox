Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUAPWjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUAPWjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:39:12 -0500
Received: from [128.173.54.129] ([128.173.54.129]:11648 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265916AbUAPWjK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 17:39:10 -0500
Message-Id: <200401162238.i0GMcxT3004785@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Hans Reiser <reiser@namesys.com>
Cc: raymond jennings <highwind747@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers 
In-Reply-To: Your message of "Fri, 16 Jan 2004 23:47:55 +0300."
             <40084DFB.5040106@namesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>
            <40084DFB.5040106@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-519977068P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Jan 2004 17:38:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-519977068P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Jan 2004 23:47:55 +0300, Hans Reiser said:

> This is already done, they are called "extent"s.  Reiser4 uses them, XFS 
> uses them, I think Veritas may have been the first to use them but I am 
> not sure of this, maybe it was IBM.

Does the extent-based disk allocation used by OS/360 in 1964 count? :)

--==_Exmh_-519977068P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFACGgDcC3lWbTT17ARAtqDAJ4xvcCy60UxvJXqBdlAdg1HVN7Q4QCg647f
l++UgDOHVbVQF0FB/GNBZ2c=
=pqI6
-----END PGP SIGNATURE-----

--==_Exmh_-519977068P--
