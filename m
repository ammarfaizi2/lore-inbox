Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267012AbUBGS1C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267018AbUBGS1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:27:01 -0500
Received: from [193.170.124.123] ([193.170.124.123]:16340 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S267012AbUBGS07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:26:59 -0500
Date: Sat, 7 Feb 2004 19:26:31 +0100
From: JG <jg@cms.ac>
To: Lincoln Dale <ltd@cisco.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TG3: very high CPU usage
In-Reply-To: <5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
References: <20040125123154.A8CA4202CAA@23.cms.ac>
	<20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<20040119033527.GA11493@linux.comp>
	<20040119033527.GA11493@linux.comp>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
	<20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
	<20040125123154.A8CA4202CAA@23.cms.ac>
	<5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
X-Mailer: Sylpheed version 0.9.8claws61 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__7_Feb_2004_19_26_31_+0100_lSZD2/gyWlAmHa8H"
Message-Id: <20040207182648.080C31A93BB@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__7_Feb_2004_19_26_31_+0100_lSZD2/gyWlAmHa8H
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

just wanted to report, that it wasn't the cable or the tg3 driver but a defective NIC. i switched to a card with a realtek 8169 chipset and now it looks muuuuch better ;) and the best thing, no errors in ifconfig.

thx for everything!
JG


--Signature=_Sat__7_Feb_2004_19_26_31_+0100_lSZD2/gyWlAmHa8H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJS3nU788cpz6t2kRAp6aAJ9BMMbc+UmaoCssuuclt+9GTAeJ+ACfUkKs
1xehoiZStJL1b71QSSTJhS8=
=QFh3
-----END PGP SIGNATURE-----

--Signature=_Sat__7_Feb_2004_19_26_31_+0100_lSZD2/gyWlAmHa8H--
