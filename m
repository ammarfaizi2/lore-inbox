Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUABCj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 21:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbUABCj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 21:39:28 -0500
Received: from h80ad2717.async.vt.edu ([128.173.39.23]:28839 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262901AbUABCj0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 21:39:26 -0500
Message-Id: <200401020239.i022dH05005627@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: DXpublica@telefonica.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: i18n for kernel 2.7.x? 
In-Reply-To: Your message of "Fri, 02 Jan 2004 01:53:58 +0100."
             <200401020153.59030.DXpublica@telefonica.net> 
From: Valdis.Kletnieks@vt.edu
References: <200312311332.15422.DXpublica@telefonica.net> <200312311625.25178.DXpublica@telefonica.net> <200312311604.hBVG4ruS000274@81-2-122-30.bradfords.org.uk>
            <200401020153.59030.DXpublica@telefonica.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1994442464P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jan 2004 21:39:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1994442464P
Content-Type: text/plain; charset=us-ascii

On Fri, 02 Jan 2004 01:53:58 +0100, Xan said:

> Well... if (all of) you think that.... 
> But, what happens with Documentation/ directory and README, COPYRIGHT, ... and 
> WEB PAGE of the kernel?
> 
> It's NOT so technically hard to do. Why not so?

Oh, give me a <bleep>ing break, already.

We demonstrably have *enough* trouble keeping the English-only contents of the
Documentation/ directory in sync with the source.  What do you propose to do if/
when some kernel change requires a document update, and we can't find somebody
who is qualified to translate to Swahili, or one of the Baltic languages(*),
and so on? Pretty soon, you have 15 or 20 slowly diverging versions due to
missed updates and the like.

As far as translating the COPYING file, I think you need to see what the FSF
thinks of translating the GPL into other languages:

http://www.fsf.org/licenses/licenses.html

(Bottom line - English is canonical, and the others are basically considered
study aids for the English-challenged).

(*) Don't look at me - although I went bughunting in the cpufreq code, and have
more relatives in Riga than I do in the US, and my Latvian is quite sufficient
to deal with a newspaper, dinner conversation, or television programming, I'd
hate to be the guy trying to understand my attempt to explain the cpufreq code
in Latvian.. ;) 


--==_Exmh_-1994442464P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/9NnUcC3lWbTT17ARArJrAJ49GnEPMalczn2Tq8Bu2nUAPUXigwCeOVlB
dpCCSR/0mA1n01B+KO4V7hs=
=YTw5
-----END PGP SIGNATURE-----

--==_Exmh_-1994442464P--
