Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVIKHO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVIKHO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVIKHO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:14:28 -0400
Received: from h80ad2452.async.vt.edu ([128.173.36.82]:54422 "EHLO
	h80ad2452.async.vt.edu") by vger.kernel.org with ESMTP
	id S932413AbVIKHO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:14:27 -0400
Message-Id: <200509110713.j8B7DsNR021781@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Lang <david.lang@digitalinsight.com>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13 
In-Reply-To: Your message of "Sat, 10 Sep 2005 23:08:36 PDT."
             <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz> 
From: Valdis.Kletnieks@vt.edu
References: <20050909214542.GA29200@kroah.com> <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz> <20050911030726.GA20462@suse.de>
            <Pine.LNX.4.62.0509102257290.29141@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126422832_12093P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 11 Sep 2005 03:13:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126422832_12093P
Content-Type: text/plain; charset=us-ascii

On Sat, 10 Sep 2005 23:08:36 PDT, David Lang said:

> remember that the distros don't package every kernel, they skip several 
> between releases and it's not going to be until they go to try them that 
> all the kinks will get worked out.

I'll bite - what distros are shipping a kernel 2.6.10 or later and still
using devfs?

--==_Exmh_1126422832_12093P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDI9kwcC3lWbTT17ARAng9AKCHqTqE7U5KHbcKJjF5O7UY0Jf9VQCgjqcJ
ZGQSHworTNRqobRKbgTstjE=
=lFX6
-----END PGP SIGNATURE-----

--==_Exmh_1126422832_12093P--
