Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWGZMeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWGZMeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWGZMeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:34:17 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:57797
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751490AbWGZMeQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:34:16 -0400
Message-Id: <200607261234.k6QCY7Eb022487@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Al Boldi <a1426z@gawab.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
In-Reply-To: Your message of "Wed, 26 Jul 2006 14:23:03 +0300."
             <200607261423.03527.a1426z@gawab.com>
From: Valdis.Kletnieks@vt.edu
References: <200607241857.52389.a1426z@gawab.com> <200607260745.45156.a1426z@gawab.com> <44C6FA1A.1020709@bigpond.net.au>
            <200607261423.03527.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153917246_5911P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 08:34:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153917246_5911P
Content-Type: text/plain; charset=us-ascii

On Wed, 26 Jul 2006 14:23:03 +0300, Al Boldi said:

> Running different scheds on a single RQ at the same time on the same resource
> would be rather odd.  That's why independent RQs are necessary even on SMP.
> OTOH, running independent RQs on UP doesn't make much sense, unless there is
> a way to relate them.

Exactly..

(But now I'm confused why you said SMP and UP were conceptually the same a
few notes back...)

--==_Exmh_1153917246_5911P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEx2E+cC3lWbTT17ARAsVpAJ0bv1X+4UoSy/PnP+qos4sWoh7gSwCbBCdv
A9LjvSEPbdnprYfQW5DRIJo=
=jsKD
-----END PGP SIGNATURE-----

--==_Exmh_1153917246_5911P--
