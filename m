Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVCAP1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVCAP1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVCAP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:27:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28423 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261924AbVCAP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:27:31 -0500
Message-Id: <200503011526.j21FQF0C005303@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writng daemon and wake up on demand. 
In-Reply-To: Your message of "Tue, 01 Mar 2005 20:43:16 +0530."
             <Pine.LNX.4.60.0503012038170.13310@lantana.cs.iitm.ernet.in> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.60.0503012038170.13310@lantana.cs.iitm.ernet.in>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109690775_4708P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Mar 2005 10:26:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109690775_4708P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Mar 2005 20:43:16 +0530, Payasam Manohar said:

> I have two doubts,
>     1) Can we design a linux daemon which will call some shell scripts.
>     2) How to call this daemon from the keyboard driver  and how
>        to kill it on demand.

It would be much easier for us to point you in the right direction if you
stopped thinking "we must call shell scripts from the keyboard driver", and
explain what problem you're trying to solve (i.e., *WHY* are you trying to
do this - is it "we need a keystroke logger", "we need keypress timing and
latencies", or some other higher-level explanation of your problem)....

--==_Exmh_1109690775_4708P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJImXcC3lWbTT17ARAtMIAKD+GmuxIL46qyfHSn87ia8O2tQYIACfToH9
0XcKewaS9QW+R883q7z1FWA=
=MOgV
-----END PGP SIGNATURE-----

--==_Exmh_1109690775_4708P--
