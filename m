Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbTAGIc6>; Tue, 7 Jan 2003 03:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267343AbTAGIc6>; Tue, 7 Jan 2003 03:32:58 -0500
Received: from h80ad273a.async.vt.edu ([128.173.39.58]:45186 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267342AbTAGIc6>; Tue, 7 Jan 2003 03:32:58 -0500
Message-Id: <200301070841.h078fLCR005634@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!) 
In-Reply-To: Your message of "Tue, 07 Jan 2003 05:14:41 -0300."
             <20030107051441.A18502@almesberger.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org> <200301070538.h075cICR004033@turing-police.cc.vt.edu> <20030107031638.D1406@almesberger.net> <200301070643.h076hWCR004411@turing-police.cc.vt.edu> <20030107040829.E1406@almesberger.net> <200301070800.h0780ECR005255@turing-police.cc.vt.edu>
            <20030107051441.A18502@almesberger.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-753923798P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Jan 2003 03:41:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-753923798P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Jan 2003 05:14:41 -0300, Werner Almesberger said:

> ... or figure out which combination of RFCs, I-Ds, and ad hoc genius
> makes up Linux TCP, yes ;-)

That's the easy part.  :)  You then get to take a cross-product of that and
its interactions with whatever combination of RFC/I-D/ad-crockery are in
the 4 different Solaris releases, the 2 or 3 AIX releases, the Tru64 releases,
the myriad different Microsoft-based servers - and that's just the 10K square
feet in our machine room.  A lot of our gear keeps trying to talk to the
outside world, where ALL bets are off. ;)

Does anybody think it would be worthwhile to collate a document of which
RFCs/I-Ds are supported, and to what extent (the MUST/SHOULD/MAY stuff)?
Or is there one already and my 3:30AM search for same is missing it? ;)

/Valdis

--==_Exmh_-753923798P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+GpKxcC3lWbTT17ARAn4UAJwLK9UasNP7yK91JpSCxy2Xo/WFWACdGbN1
lqxM/L9ay7C3QzB5PiVutkc=
=eVW0
-----END PGP SIGNATURE-----

--==_Exmh_-753923798P--
