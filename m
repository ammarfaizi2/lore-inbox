Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbTGHWB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267764AbTGHWB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:01:57 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:18639 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S267751AbTGHWBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:01:52 -0400
Subject: Re: Forking shell bombs
From: Max Valdez <maxvalde@fis.unam.mx>
To: system_lists@nullzone.org, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.2.20030708235404.02b9ec80@192.168.2.130>
References: <20030708202819.GM1030@dbz.icequake.net>
	 <20030708193401.24226.95499.Mailman@lists.us.dell.com>
	 <20030708202819.GM1030@dbz.icequake.net>
	 <5.2.1.1.2.20030708235404.02b9ec80@192.168.2.130>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BXmfkY0mCLLKWZaIY951"
Message-Id: <1057684703.6241.3.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 12:18:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BXmfkY0mCLLKWZaIY951
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I set the ulimit -u 1791
and the box keeps running(2.4.20-gentoo-r5) , but we still need the
problem corrected, any other user can run ther DOS and crash the box, is
there any way to set ulimits for all users fixed ??, not by sourcein a
bashrc or something like that ?? because the user can delete the line on
.bashrc and thats it

Max
--=20
uname -a: Linux garaged 2.4.20-gentoo-r5 #6 SMP Wed Jun 4 15:32:53 Local ti=
me zone must be set--see zic m i686 Pentium III (Coppermine) GenuineIntel G=
NU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-BXmfkY0mCLLKWZaIY951
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CvzfsrSE6THXcZwRAjmgAKCoY5XieXOCsASnUM69plIex/wKjgCbBk0Q
7Ngo0deMM47nlUVFjexGMQ0=
=GcJb
-----END PGP SIGNATURE-----

--=-BXmfkY0mCLLKWZaIY951--

