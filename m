Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUDOOJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbUDOOJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:09:49 -0400
Received: from 68-184-155-122.cpe.ga.charter.com ([68.184.155.122]:54244 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S264022AbUDOOJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:09:13 -0400
Date: Thu, 15 Apr 2004 10:09:04 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ip_contrack bug in 2.4?
Message-ID: <20040415140904.GB7975@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I saw the bug where you can hang a box by "cat /proc/net/ip_conntrack"
seems to have been fixed in 2.6.  Has it been fixed in 2.4.26?  Bare
2.4.25 is still vulnerable as my co-workers are proving to each other...


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

With Dreams To Be A King First One Should Be A Man
					- Manowar


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfpeA8+1vMONE2jsRAtnLAJ4+JE4NSlStmBOEL83m+T4OmlS12ACfX0YD
MWlyfg2KoAp9EOvO3gW3H8o=
=dA0q
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
