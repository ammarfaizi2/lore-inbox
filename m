Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbTCIDRu>; Sat, 8 Mar 2003 22:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbTCIDRu>; Sat, 8 Mar 2003 22:17:50 -0500
Received: from h80ad267b.async.vt.edu ([128.173.38.123]:14467 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262383AbTCIDRt>; Sat, 8 Mar 2003 22:17:49 -0500
Message-Id: <200303090328.h293SH7U007070@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] updated scheduler-tunables for 2.5.64-mm2 
In-Reply-To: Your message of "Sat, 08 Mar 2003 18:18:51 PST."
             <477140000.1047176330@[10.10.2.4]> 
From: Valdis.Kletnieks@vt.edu
References: <20030307185116.0c53e442.akpm@digeo.com> <1047095088.727.5.camel@phantasy.awol.org> <400810000.1047147915@[10.10.2.4]> <1047174868.719.7.camel@phantasy.awol.org>
            <477140000.1047176330@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1474792192P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Mar 2003 22:28:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1474792192P
Content-Type: text/plain; charset=us-ascii

On Sat, 08 Mar 2003 18:18:51 PST, "Martin J. Bligh" said:

> > But at least in 2.5.64 and 2.5.64-mm3, I do not see those parameters. 
> > There is no {IDLE|BUSY}_NODE_REBALANCE_TICK define.
> 
> Ooops. Sorry ... we have to merge Ingo's NUMA sched updates first ;-)
> /me goes back to swinging about in his own tree ...

Hey Larry - looks like some people you can sell a Bitkeeper license to. ;)

--==_Exmh_1474792192P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+arTQcC3lWbTT17ARAk3vAKDY1vCDZGZT0mqVL/OoVSS5RxYlggCdHRIq
zjTx8ssk9h6S48I9uTszBHA=
=jsH4
-----END PGP SIGNATURE-----

--==_Exmh_1474792192P--
