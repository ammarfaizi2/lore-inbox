Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVI1JXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVI1JXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVI1JXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:23:55 -0400
Received: from h80ad25b8.async.vt.edu ([128.173.37.184]:26509 "EHLO
	h80ad25b8.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750813AbVI1JXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:23:54 -0400
Message-Id: <200509280923.j8S9Nkgq028579@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: iodophlymiaelo@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: raw aio write guarantee 
In-Reply-To: Your message of "Wed, 28 Sep 2005 01:56:05 PDT."
             <98b62faa050928015677d7253b@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <98b62faa050928001275d28771@mail.gmail.com> <200509280757.j8S7vmjB023730@turing-police.cc.vt.edu>
            <98b62faa050928015677d7253b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127899425_31960P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Sep 2005 05:23:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127899425_31960P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Sep 2005 01:56:05 PDT, iodophlymiaelo@gmail.com said:

> I was asking what a user-application can do to prevent data loss, not
> an application-user.

Right.  However, if you actually care about the distinction between "made it
to the disk cache" and "made it to the platter", those are things you'll
want to address - in particular, if you have one of the evil disk drives
I mentioned, there's very little a user application can do to work around it.


--==_Exmh_1127899425_31960P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDOmEhcC3lWbTT17ARAphVAJ43tNjjCmZ1v/REVqW4WdIHjs8NUgCfZiEj
NGsVDOZjptyHqGvEhboMM7s=
=bCZB
-----END PGP SIGNATURE-----

--==_Exmh_1127899425_31960P--
