Return-Path: <linux-kernel-owner+w=401wt.eu-S932281AbXAGA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbXAGA2c (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbXAGA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:28:32 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45352 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbXAGA2b (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:28:31 -0500
Message-Id: <200701070028.l070SQS0004315@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - reiser4-sb_sync_inodes.patch causes boot hang
In-Reply-To: Your message of "Sat, 06 Jan 2007 11:14:21 PST."
             <20070106111421.457e2ad2.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701061520.l06FKntg003207@turing-police.cc.vt.edu>
            <20070106111421.457e2ad2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168129706_4071P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 06 Jan 2007 19:28:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168129706_4071P
Content-Type: text/plain; charset=us-ascii

On Sat, 06 Jan 2007 11:14:21 PST, Andrew Morton said:
>
> Yeah, that's an akpm screwup, sorry.
> 
> Take a peek in
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/hot-fixes/

Confirming that reiser4-sb_sync_inodes-fix.patch fixes my problem.

--==_Exmh_1168129706_4071P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFoD6qcC3lWbTT17ARAmLQAJ90btlo7NTfFSzYrDxDw3exu8oM2wCglYgg
+Cp79goKO+1ZOHU4YzhAznY=
=lA5Y
-----END PGP SIGNATURE-----

--==_Exmh_1168129706_4071P--
