Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTEIP5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 11:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTEIP5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 11:57:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32129 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263301AbTEIP5v (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 11:57:51 -0400
Message-Id: <200305091609.h49G9ib9008119@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: VIA IDE still broken 
In-Reply-To: Your message of "Fri, 09 May 2003 00:09:10 +0200."
             <20030508220910.GA1070@codeblau.de> 
From: Valdis.Kletnieks@vt.edu
References: <20030508220910.GA1070@codeblau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_240982716P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 09 May 2003 12:09:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_240982716P
Content-Type: text/plain; charset=us-ascii

On Fri, 09 May 2003 00:09:10 +0200, Felix von Leitner <felix-kernel@fefe.de>  said:

> does OTP, finalizing or eject.  The nvidia graphics card takes major
> patching to work at all with X, and all of these components are

Umm... see http://www.minion.de/nvidia - or have you tried that and it
still doesn't work, or you trying to get the XFree driver working, or is
it some other issue?

(One gotcha that hosed *ME* up was the fact that recent XFree86 are TLS-sensitive,
and NVidia's latest few series of drivers included TLS libs for OpenGL - but
I didn't have /lib/tls and/or /usr/lib/tls in /etc/ld.so.conf so ldconfig
didn't DTRT - THAT horqued things up but good).


--==_Exmh_240982716P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+u9LHcC3lWbTT17ARAi3WAJ9UCh3Bq5tnZ8DYWYPBNHAGGsskqwCgptWa
HCbzuJU23XI4QQm+NNq+/Gk=
=9eKj
-----END PGP SIGNATURE-----

--==_Exmh_240982716P--
