Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTKETuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKETuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:50:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263179AbTKETu0 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:50:26 -0500
Message-Id: <200311051950.hA5JoO0s002149@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: balaji raghavan <braghava@usc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pseudo disk interface 
In-Reply-To: Your message of "Wed, 05 Nov 2003 11:04:38 PST."
             <e9bdb4e9ef4a.e9ef4ae9bdb4@usc.edu> 
From: Valdis.Kletnieks@vt.edu
References: <e9bdb4e9ef4a.e9ef4ae9bdb4@usc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1047330874P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Nov 2003 14:50:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1047330874P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Nov 2003 11:04:38 PST, balaji raghavan <braghava@usc.edu>  said:

>     Is there a some kind of __disk_abstraction__ existent in Linux? I am
> trying to write a Cryptographic disk driver for linux. But AFAIK, I would have
> to write a pseudo disk interface viz. some disk abstraction driver. Can anyone
> help me on this?

See these:

drivers/block/loop.c
drivers/block/cryptoloop.c



--==_Exmh_-1047330874P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qVR/cC3lWbTT17ARAhT9AKDIk6Meo7nkKiv/hwc2lwDKPy+aEQCfSNfe
xI6Ai1ZTIRug8hnEZz/1Es8=
=T2LH
-----END PGP SIGNATURE-----

--==_Exmh_-1047330874P--
