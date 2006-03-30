Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWC3SC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWC3SC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWC3SC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:02:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60299 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751350AbWC3SCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:02:55 -0500
Message-Id: <200603301802.k2UI2hN1016850@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, beware <wimille@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming 
In-Reply-To: Your message of "Thu, 30 Mar 2006 08:09:14 EST."
             <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr>
            <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143741763_4126P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Mar 2006 13:02:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1143741763_4126P
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Mar 2006 08:09:14 EST, "linux-os (Dick Johnson)" said:

> For instance __all__ real numbers, except for transcendentals, can
> be represented as a ratio of two integers. For instance, you can't
> represent 1/3 exactly as a decimal.

That's a "rational" number (or alternately, an algebraic number of order 1.
Irrational numbers result from algebraic expressions but aren't representable
as a ratio (for instance, the square root of 2, or the number phi - both of
these are algebraic numbers of order 2).   Trancendentals are numbers which
can't result from algebraic expressions with whole number coefficients (for
instance, pi and e).

All transcendentals are irrational, but not all irrationals are transcendental.

http://mathworld.wolfram.com/AlgebraicNumber.html
http://mathworld.wolfram.com/IrrationalNumber.html
http://mathworld.wolfram.com/TranscendentalNumber.html
http://mathworld.wolfram.com/GoldenRatio.html

--==_Exmh_1143741763_4126P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFELB1DcC3lWbTT17ARAswzAJ0eLe4vSXa/k3wB5DLR55eV61lZ3ACfdw6q
We2CWLbLsrQDe8FrNXiY6Xg=
=XRVL
-----END PGP SIGNATURE-----

--==_Exmh_1143741763_4126P--
