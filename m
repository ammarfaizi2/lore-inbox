Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUGBLKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUGBLKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUGBLHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:07:15 -0400
Received: from mout0.freenet.de ([194.97.50.131]:32138 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S263032AbUGBLCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 07:02:35 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: binutils woes
Date: Fri, 2 Jul 2004 12:56:16 +0200
User-Agent: KMail/1.6.2
References: <20040701175231.B8389@flint.arm.linux.org.uk>
In-Reply-To: <20040701175231.B8389@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407021256.18399.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Russell King <rmk+lkml@arm.linux.org.uk>:
> GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux

Is there a chance that this screws up binaries for x86, too?
I'm having various segfault problems at the moment. Maybe I should
update.

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5T9QFGK1OIvVOP4RAnraAJ0eODTOfojvwKfwISmbK4ZSRlD2NgCgj7o7
QV61gaI87O0K7xBbzcLf5Sc=
=bKrH
-----END PGP SIGNATURE-----
