Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268055AbUGWVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268055AbUGWVEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUGWVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:04:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19388 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268055AbUGWVEj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:04:39 -0400
Message-Id: <200407232104.i6NL4Zwf003593@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4+dev
To: vherva@viasys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs) 
In-Reply-To: Your message of "Fri, 23 Jul 2004 09:31:31 +0300."
             <20040723063131.GJ16073@viasys.com> 
From: Valdis.Kletnieks@vt.edu
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722152839.019a0ca0.pj@sgi.com> <20040722232540.GH19329@fs.tum.de> <1090549329.6113.21.camel@kryten.internal.splhi.com>
            <20040723063131.GJ16073@viasys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2012057884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jul 2004 17:04:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2012057884P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Jul 2004 09:31:31 +0300, Ville Herva said:

> Anyway, as (one kind of) end user, I do welcome the new development model.
> I'll get the newest features in manageable manner, and if I don't fancy that
> I can resort to vendor (Fedora) kernels.

You *do* realize that the kernel in the Fedora development tree is actually *ahead*
of the released kernel.org tree, right?

The current kernel-2.6.7-1.494.src.rpm is based on 2.6.8-rc1-bk5, with a bunch of
RedHat/Fedora patches on top of that.

And the 2.6.5-1.358 kernel that shipped in Fedora Core 2 is actually a 2.6.6-rc3-bk3
with patches on top of that.

I think you meant the RHEL series of kernels - current there is 2.4.21-15.0.3.EL,
with backports of security/bug fixes.

--==_Exmh_2012057884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBAX1icC3lWbTT17ARAkpYAJ91L0CUEBuzESDGtZfa7Kim0qk4ywCggpuA
3xJ34cQXqqIbFom6b7KK8H8=
=gRxk
-----END PGP SIGNATURE-----

--==_Exmh_2012057884P--
