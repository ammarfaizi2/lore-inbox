Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVCPSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVCPSNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVCPSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:13:11 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40711 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262720AbVCPSNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:13:05 -0500
Message-Id: <200503161812.j2GICv9V018998@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4 and 2.6.11.4 
In-Reply-To: Your message of "Wed, 16 Mar 2005 12:57:15 EST."
             <200503161257.21571.pmcfarland@downeast.net> 
From: Valdis.Kletnieks@vt.edu
References: <200503161257.21571.pmcfarland@downeast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1110996777_3964P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Mar 2005 13:12:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1110996777_3964P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Mar 2005 12:57:15 EST, Patrick McFarland said:

> I've been running -mm for about a year now, and the whole thing with 2.6.11.x
> releases coming out quite often is a little confusing. Does 2.6.11-mm4 still
> apply to 2.6.11 (no bloody 1, 2, 3, or 4), and if so, what does -mm4 contain
> from the .x versions (ie, does -mm4 contain the updates from 2.6.11.3 or 4 as
> well?)

The -mm patches apply on top of a clean 2.6.11.

They *should* contain all the 2.6.11.4 fixes, because Andrew includes the
bk-linus.patch in -mm, and the 2.6.x.y policy is that the patch (or a variant
thereof) already be in upstream.  So Linus's tree has to have it in it, so
the -mm tree should have it.

If you find something that's in 2.6.x.y that *isn't* in a subsequently released
-mm, I suggest you contact Greg, Linus, and Andrew, as it means we've collectively
borked something...


--==_Exmh_1110996777_3964P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCOHcpcC3lWbTT17ARAhbUAKC/zHr4CWrQmHIPF5GAXVMIu8GbyQCgnLbe
iEOs6xF7eoP1/USsaVYgWrw=
=/5lw
-----END PGP SIGNATURE-----

--==_Exmh_1110996777_3964P--
