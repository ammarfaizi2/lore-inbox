Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUADWnO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUADWnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:43:13 -0500
Received: from [193.170.124.123] ([193.170.124.123]:52020 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S265351AbUADWnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:43:11 -0500
Date: Sun, 4 Jan 2004 23:42:59 +0100
From: JG <jg@cms.ac>
To: linux-kernel@vger.kernel.org
Subject: Re: Any hope for HPT372/HPT374 IDE controller?
In-Reply-To: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
References: <S265365AbUADWL5/20040104221159Z+4976@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__4_Jan_2004_23_42_59_+0100_5eh0rpLFQ29=pmb4"
Message-Id: <20040104224308.BD3941A943A@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__4_Jan_2004_23_42_59_+0100_5eh0rpLFQ29=pmb4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi, 

> Have any recent improvements been made? Does anyone have one of these controllers actually working correctly?

i have two hpt374 controllers (rocketraid 404, both latest bios) in two of my machines.
i've been using kernel 2.4.19 with the driver v2.1 from highpoint for a long time (with high loads, many disks attached to the controllers) without any problems in both machines (except that some disks died, but that's another thing ;))
at the moment i'm using kernel 2.6.0 on one server with the integrated driver (because there's no highpoint driver yet) and it is working fine so far, but it didn't get stressed much lately.
i'm currently testing 2.6.1-rc1-mm1 on the other machine (which i can reboot more often) - also no problems (yet ;)).
both machines have sis chipsets (sis735 and sis745), if you need more info for debugging/comparing just tell me.

i can remember though that i've had some problems (dunno anymore what problems exactly) with the integrated drivers in the past, hence i was using the one's from highpoint.

JG

--Signature=_Sun__4_Jan_2004_23_42_59_+0100_5eh0rpLFQ29=pmb4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+Jb7U788cpz6t2kRAp+ZAJ0SBMZK4UkrzRXX62sHYGdbWCVQsgCfYQIY
gZis/Z+mwmrroTkKQzDq2xU=
=APyq
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Jan_2004_23_42_59_+0100_5eh0rpLFQ29=pmb4--
