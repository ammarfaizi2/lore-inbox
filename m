Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUBEOob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUBEOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:44:31 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3712 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265238AbUBEOoV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:44:21 -0500
Message-Id: <200402051119.i15BJxFO027912@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: jmorris@redhat.com, aviro@redhat.com, sds@epoch.ncsc.mil,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, chrisw@osdl.org
Subject: Re: [PATCH] (3/3) SELinux context mount support - SELinux changes. 
In-Reply-To: Your message of "Thu, 05 Feb 2004 02:40:16 PST."
             <20040205024016.281a1c5a.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0402040953280.4796-100000@thoron.boston.redhat.com> <200402051017.i15AHA99025783@turing-police.cc.vt.edu>
            <20040205024016.281a1c5a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_54503430P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Feb 2004 06:19:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_54503430P
Content-Type: text/plain; charset=us-ascii

On Thu, 05 Feb 2004 02:40:16 PST, Andrew Morton said:

> All that text is lovingly shovelled into the changelogs.  They're damn hard
> to get at via the bk web interface but with `bk revtool' it's a snap.  Go
> to a line in a .c file, double-click on it, see the diffview and the full
> changelog.

Wow.. So you go to line 300 or so of drivers/block/as-iosched.c and
a doubleclick pulls up Documentation/as-iosched.txt? Coooool ;)

% which bk
/usr/bin/which: no bk in (/home/valdis/bin:/usr/local/bin:/usr/bin/X11:/bin:/usr/bin:/usr/sbin:/sbin)

Damn. :)


--==_Exmh_54503430P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIibecC3lWbTT17ARAg8TAJ4tupkGecGrXrK1nrBTg+z/j5oVIwCdGsC3
fr9L7xV4+duP0S6M2I9Meh8=
=6ITz
-----END PGP SIGNATURE-----

--==_Exmh_54503430P--
