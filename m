Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVA0HLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVA0HLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVA0HLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:11:13 -0500
Received: from h80ad2540.async.vt.edu ([128.173.37.64]:20498 "EHLO
	h80ad2540.async.vt.edu") by vger.kernel.org with ESMTP
	id S262522AbVA0HLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:11:06 -0500
Message-Id: <200501270710.j0R7AhIN003672@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL? 
In-Reply-To: Your message of "Thu, 27 Jan 2005 01:51:05 EST."
             <41F88F59.6040904@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net> <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk> <41F86176.3010000@comcast.net> <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu>
            <41F88F59.6040904@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106809843_17814P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jan 2005 02:10:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106809843_17814P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jan 2005 01:51:05 EST, John Richard Moser said:

> mmm.  I'd thought about that actually-- for modules to get a whack at
> this they'd have to be compiled in.  Loaded as modules would break the
> security.

And that, my friends, is *exactly* why SELinux can't be built as a module ;)

--==_Exmh_1106809843_17814P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB+JPzcC3lWbTT17ARAmzKAKDxvdQh/aqF9oM+AclVH8F1LYRuZwCfXNKv
+8x0d3/UKWgIEmg8XDBfbnI=
=CDjH
-----END PGP SIGNATURE-----

--==_Exmh_1106809843_17814P--
