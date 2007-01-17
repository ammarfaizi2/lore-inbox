Return-Path: <linux-kernel-owner+w=401wt.eu-S1751013AbXAQWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbXAQWyT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXAQWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:54:19 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45613 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbXAQWyS (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:54:18 -0500
Message-Id: <200701172254.l0HMsDMK022934@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
In-Reply-To: Your message of "Wed, 17 Jan 2007 17:04:20 EST."
             <Pine.LNX.4.64.0701171654480.4298@CPE00045a9c397f-CM001225dbafb6>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6> <200701172154.l0HLs3BM021024@turing-police.cc.vt.edu>
            <Pine.LNX.4.64.0701171654480.4298@CPE00045a9c397f-CM001225dbafb6>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1169074453_4892P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 Jan 2007 17:54:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1169074453_4892P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Jan 2007 17:04:20 EST, "Robert P. J. Day" said:

> > How much of the 'OBSOLETE' code should just be labelled 'BROKEN'
> > instead?
> 
> the stuff that's actually "broken."  :-)

Right - the question is how much code qualifies as either/both, and which
we should use when we encounter the random driver that's both obsolete
*and* broken...

--==_Exmh_1169074453_4892P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFrqkVcC3lWbTT17ARApV5AJ43PHHOTCKjbVc5KFz/bAlWPgnIlwCgodA1
wpGxFc8tw0ECXtrISV0vjiU=
=avvj
-----END PGP SIGNATURE-----

--==_Exmh_1169074453_4892P--
