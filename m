Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbUAVMzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 07:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUAVMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 07:55:39 -0500
Received: from [193.170.124.123] ([193.170.124.123]:10032 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S264508AbUAVMzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 07:55:38 -0500
Date: Thu, 22 Jan 2004 13:55:07 +0100
From: JG <jg@cms.ac>
To: Lincoln Dale <ltd@cisco.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>,
       Andreas Hartmann <andihartmann@freenet.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TG3: very high CPU usage
In-Reply-To: <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
References: <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<20040119033527.GA11493@linux.comp>
	<20040119033527.GA11493@linux.comp>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__22_Jan_2004_13_55_07_+0100_tN3Xeey9P4v1JT=i"
Message-Id: <20040122125516.7B671202CDC@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__22_Jan_2004_13_55_07_+0100_tN3Xeey9P4v1JT=i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> nope.
> i didn't use PREEMPT=y in my previous test, but i have just done so now.

i have preempt enabled on both machines. at the moment i don't have time to recompile my kernel, but i'm going to test 2.6.2-rc1-mm1 soon on one of my machines where i'll disable it.

i'm also going to test my systems with ttcp, because at the moment i'm transferring my backup from the server to my machine with 105.48 kB/s over the gigabit line via ftp :( but cpu is normal on both machines.

JG


--Signature=_Thu__22_Jan_2004_13_55_07_+0100_tN3Xeey9P4v1JT=i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAD8gzU788cpz6t2kRAgRrAJoDNlhDR3I/tRiYdBscfaXwHbAl4wCgiIs3
dq5JpGbikq4qLsH1+iVVOS4=
=/IKD
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Jan_2004_13_55_07_+0100_tN3Xeey9P4v1JT=i--
