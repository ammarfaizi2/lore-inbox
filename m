Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUCKTkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbUCKTkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:40:11 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:37249 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261671AbUCKTkD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:40:03 -0500
Message-Id: <200403111939.i2BJdxrx004553@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: pg smith <pete@linuxbox.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LKM rootkits in 2.6.x 
In-Reply-To: Your message of "Thu, 11 Mar 2004 11:26:23 PST."
             <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0403111124020.27770-100000@linuxbox.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_770563481P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Mar 2004 14:39:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_770563481P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 Mar 2004 11:26:23 PST, pg smith <pete@linuxbox.co.uk>  said:
> Any thoughts on the future of LKM rootkits in the 2.6 kernel branch ? In

Speak of the devil...

Subject: Announcing full functional adore-ng rootkit for 2.6 Kernel
From: stealth <stealth@segfault.net>
Date: Thu, 11 Mar 2004 10:27:00 +0000
To: bugtraq@securityfocus.com

Hi,

At http://stealth.7350.org/rootkits/adore-ng-0.41.tgz you find
the complete port of adore-ng for the Linux kernel 2.6. All
of the stuff you know from earlier kernel 2.4 versions such
as socket-, process- and file-hiding, syslog- and [uw]tmp filtering
has been ported. Additionally since version 0.32 a buffer overflow has
been fixed (doh!) which could lead to crashes when a lot of network
connections exist.

regards,
stealth-


--==_Exmh_770563481P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAUMCPcC3lWbTT17ARApLzAKC/qfe8sdEe0E5LYve3c2qoyDyQfACg9eQj
Ck2pPeIu8ruYM9ChvZdLITA=
=4WCj
-----END PGP SIGNATURE-----

--==_Exmh_770563481P--
