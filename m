Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUIBTMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUIBTMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIBTMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:12:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45291 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268184AbUIBTMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:12:39 -0400
Message-Id: <200409021912.i82JCRcw013366@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Chris Wright <chrisw@osdl.org>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Identify security-related patches 
In-Reply-To: Your message of "Thu, 02 Sep 2004 11:48:07 PDT."
             <20040902114807.G1973@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <4136C6E1.4090404@bio.ifi.lmu.de>
            <20040902114807.G1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_849479122P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Sep 2004 15:12:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_849479122P
Content-Type: text/plain; charset=us-ascii

On Thu, 02 Sep 2004 11:48:07 PDT, Chris Wright said:
> * Frank Steiner (fsteiner-mail@bio.ifi.lmu.de) wrote:
> > is there an easy way to identify all security-related patches out of the
> > mass of patches floating around  on linux.bkbits.net or the kernel bugzilla?
> 
> No, there's not.  It's not as simple as it seems.  Your best bet is
> monitoring vendor updates, as they have the same goal.  Occasionaly
> things get applied with a CVE candidate number (CAN-YYYY-NNNN), and
> those are security relevant.

Another point to remember is that there are probably many times that we've
fixed something because it's a bug, and only later find out that it's a bug
with security implications...

--==_Exmh_849479122P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBN3CacC3lWbTT17ARAkMbAKDo20aEHPm6DD6r48KA5AD5F1ekFgCfXqMh
V4CtadxL6QvnR9rnC8te15E=
=mi6L
-----END PGP SIGNATURE-----

--==_Exmh_849479122P--
