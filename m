Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTJQOqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTJQOqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:46:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6272 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263477AbTJQOql (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:46:41 -0400
Message-Id: <200310171446.h9HEkbbN005736@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc reliability & performance 
In-Reply-To: Your message of "Fri, 17 Oct 2003 02:10:40 PDT."
             <20031017021040.4964309a.davem@redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <1066356438.15931.125.camel@cube> <20031017023437.GB28158@work.bitmover.com> <01e601c39484$f3fa31c0$890010ac@edumazet>
            <20031017021040.4964309a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1734452520P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Oct 2003 10:46:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1734452520P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Oct 2003 02:10:40 PDT, "David S. Miller" said:

> > tools like "netstat" or "lsof", (even with -n flag) are just unusable.
> 
> Because they don't use the netlink TCP socket dumping
> facility which is made to handle such things much better
> than procfs ever can.

The netlink TCP socked dumping facility will also provide the
"open files" list of *non* sockets that lsof wants?

Not all the world's a TCP connection....

--==_Exmh_1734452520P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/kADNcC3lWbTT17ARAg22AKD9Qdt/RpltBAuovL7pKPlHh4EwegCgq/Ud
laXp5eh4gEW+VCJV8XVFQJg=
=jSd+
-----END PGP SIGNATURE-----

--==_Exmh_1734452520P--
