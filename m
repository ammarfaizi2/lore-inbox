Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTKTFL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTKTFL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:11:58 -0500
Received: from h80ad2583.async.vt.edu ([128.173.37.131]:53648 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261326AbTKTFL5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:11:57 -0500
Message-Id: <200311200511.hAK5Bmsp010268@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper 
In-Reply-To: Your message of "Wed, 19 Nov 2003 20:38:48 PST."
             <20031120043848.GG19856@holomorphy.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au>
            <20031120043848.GG19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1391753850P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Nov 2003 00:11:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1391753850P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Nov 2003 20:38:48 PST, William Lee Irwin III said:

> It's very much a second-class flavor of open source. They dare not
> change the kernel version lest the binary-only trainwreck explode.
> They dare not run with the whiz-bang patches going around they're
> interested in lest the binary-only trainwreck explode. It may oops
> in mainline, and all they can do is wait for a tech support line to
> answer. Well, they're a little better than that, they have hackers
> out and about, but you're still stuck waiting for a specific small
> set of individuals and lose all of the "many eyes" advantages.

On the flip side, if I go back as far as 2.5.4<mumble>, I've had a lot more
days where the open-source drivers for my Xircom ethernet/modem card were
broken than days where my binary NVidia driver was broken.  Also, the Xircom
has been the cause of a lot more "hang before even single user mode" problems,
and several times the Xircom didn't start working again until there was a
complete overhaul of the Cardbus support, while there's not been that much
activity on the NVidia patch on www.minion.de.

It's certainly seemed like I've ended up "stuck waiting for a specific
small set of individuals" when the Cardbus support has broken (not to
slight them, they're all great guys and  do support the stuff) - how many
people on this list *really* understand that code?  And it's not just
the Cardbus stuff - there's a LOT of stuff in the kernel that's only
really understood by a very small number of people.


--==_Exmh_1391753850P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/vE0ScC3lWbTT17ARAuhvAKC5iEZB20g0eGhg8lpbWbvJ2n8Z1gCeIRMn
kVqLeC2RpAIoriSkXqQSxUU=
=QrVU
-----END PGP SIGNATURE-----

--==_Exmh_1391753850P--
