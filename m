Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVCABr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVCABr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 20:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCABr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 20:47:58 -0500
Received: from h80ad25cd.async.vt.edu ([128.173.37.205]:25610 "EHLO
	h80ad25cd.async.vt.edu") by vger.kernel.org with ESMTP
	id S261197AbVCABrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 20:47:52 -0500
Message-Id: <200503010147.j211lUsf024781@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: updating mtime for char/block devices? 
In-Reply-To: Your message of "Tue, 01 Mar 2005 01:45:47 +0100."
             <4223BB3B.4060309@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <42225CEE.1030104@gmx.net> <1109576878.6298.49.camel@laptopd505.fenrus.org>
            <4223BB3B.4060309@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109641650_3594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Feb 2005 20:47:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109641650_3594P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Mar 2005 01:45:47 +0100, Carl-Daniel Hailfinger said:

> Sorry for not specifying my real problem which is preventing disk access
> when my laptop is running on battery.
> 
> Can I prevent mtime updates for all device files? Mounting /dev readonly
> would certainly help, but for that to work I'd have to move /dev to a
> different filesystem, right?

Or do what Fedora Core 3 does and use 'udev' to manage a /dev on a tmpfs file system.

--==_Exmh_1109641650_3594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCI8mycC3lWbTT17ARAkmhAJ98Cjr1NdmQqULcsgjAg6F4YiuXZwCgvyDq
Xxt6km2FioFofh+oTirkxLk=
=jDgG
-----END PGP SIGNATURE-----

--==_Exmh_1109641650_3594P--
