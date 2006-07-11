Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWGKMgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWGKMgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWGKMgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:36:25 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:54213
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750711AbWGKMgY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:36:24 -0400
Message-Id: <200607111235.k6BCZcO2030010@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 - VPN chewing CPU like crazy..
In-Reply-To: Your message of "Mon, 10 Jul 2006 23:19:39 PDT."
             <20060710231939.256a017a.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <200607110420.k6B4KMZM013584@turing-police.cc.vt.edu>
            <20060710231939.256a017a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152621337_4450P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 08:35:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152621337_4450P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jul 2006 23:19:39 PDT, Andrew Morton said:

> > Any suggestions/hints (besides rebuilding the implicated .ko with debugging
> > symbols so oprofile can be more granular - that's already on the to-do list)?
> > 
> 
> I'd suggest you whack sysrq-T 5-10 times when it happens, capture a few
> stack traces.

"D-Oh!" -- Homer Simpson.

I knew that. :)


--==_Exmh_1152621337_4450P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEs5sZcC3lWbTT17ARAqloAJoDElgCPlL7JZAxrdmTPgC1Cw4qwACdHC6W
aqnPsi9+uHCppbxQAPQCdj8=
=bWiE
-----END PGP SIGNATURE-----

--==_Exmh_1152621337_4450P--
