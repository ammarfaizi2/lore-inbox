Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbUAEOyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbUAEOyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:54:24 -0500
Received: from [68.114.43.143] ([68.114.43.143]:60322 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264487AbUAEOyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:54:22 -0500
Date: Mon, 5 Jan 2004 09:54:21 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: mremap bug and 2.4?
Message-ID: <20040105145421.GC2247@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Just read this on full disclosure:

http://isec.pl/vulnerabilities/isec-0013-mremap.txt

Is it valid?  No working proof of concept code has been posted so I can't=
=20
test my systems.  The article only lists 2.4 and 2.6.  Is this
2.4.16-current, etc?  Anyone have any details about versions that are
safe so I/We can determine if I need to roll a new production kernel out
again?

Thanks,
  Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+Xqd8+1vMONE2jsRAhjyAJ9n4QF7bFAJ7qSeIAS1NWwLH7aRCQCfVM+/
NiI6vNKWI5YMa5leY8MSIVc=
=NBqO
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
