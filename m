Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTJSQbT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTJSQbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:31:19 -0400
Received: from h80ad26a8.async.vt.edu ([128.173.38.168]:13442 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262013AbTJSQbR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:31:17 -0400
Message-Id: <200310191631.h9JGVEN5030083@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation 
In-Reply-To: Your message of "Sun, 19 Oct 2003 18:14:55 +0200."
             <20031019161454.GD12627@wiggy.net> 
From: Valdis.Kletnieks@vt.edu
References: <I2Ue.7PG.5@gated-at.bofh.it> <I2Ue.7PG.7@gated-at.bofh.it> <I2Ue.7PG.9@gated-at.bofh.it> <I2Ue.7PG.11@gated-at.bofh.it> <I2Ue.7PG.13@gated-at.bofh.it> <I2Ue.7PG.1@gated-at.bofh.it> <ImzK.4TR.25@gated-at.bofh.it> <ImzK.4TR.23@gated-at.bofh.it> <InYQ.6OJ.21@gated-at.bofh.it> <3F92B62C.8020602@softhome.net>
            <20031019161454.GD12627@wiggy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_954831722P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Oct 2003 12:31:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_954831722P
Content-Type: text/plain; charset=us-ascii

On Sun, 19 Oct 2003 18:14:55 +0200, Wichert Akkerman <wichert@wiggy.net>  said:
> Previously Ihar 'Philips' Filipau wrote:
> >   The goal of kernel is to provide framework for applications to the 
> > job well.
> 
> I doubt anyone using linux for routing would agree with you.

OK, so the applications are limited to /sbin/iptables, /sbin/route, /bin/
netstat, and maybe dhcpd and/or zebra. They're still applications, even if they
end up invoking a lot of kernel resources on their behalf.


--==_Exmh_954831722P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/krxRcC3lWbTT17ARAkI9AJ0ZXHxt8EX0G6PpAsQoKonZoOZLBgCgrJOO
Fi7ZJgYQYmy0zOcxcOPFd4g=
=PL/8
-----END PGP SIGNATURE-----

--==_Exmh_954831722P--
