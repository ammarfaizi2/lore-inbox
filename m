Return-Path: <linux-kernel-owner+w=401wt.eu-S1751304AbXAQVyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbXAQVyH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbXAQVyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:54:07 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37462 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbXAQVyG (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:54:06 -0500
Message-Id: <200701172154.l0HLs3BM021024@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
In-Reply-To: Your message of "Wed, 17 Jan 2007 11:51:27 EST."
             <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1169070843_4892P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Jan 2007 16:54:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1169070843_4892P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Jan 2007 11:51:27 EST, "Robert P. J. Day" said:
>
>   in any event, what about introducing a new config variable,
> OBSOLETE, under "Code maturity level options"?  this would seem to be
> a quick and dirty way to prune anything that is *supposed* to be
> obsolete from the build, to make sure you're not picking up dead code
> by accident.
> 
>   i think it would be useful to be able to make that kind of
> distinction since, as the devfs writer pointed out above, the point of
> labelling something "obsolete" is not to *discourage* someone from
> using a feature, it's to imply that they *shouldn't* be using that
> feature.  period.  which suggests there should be an easy, one-step
> way to enforce that absolutely in a build.

How much of the 'OBSOLETE' code should just be labelled 'BROKEN' instead?

--==_Exmh_1169070843_4892P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFrpr7cC3lWbTT17ARAkRIAKCJ9J+8muj86atq6Hfwean1LBU70gCgt4YJ
qphHZ6nBXc8Pt2hpAJdwa4s=
=RZu2
-----END PGP SIGNATURE-----

--==_Exmh_1169070843_4892P--
