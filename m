Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUESS4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUESS4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 14:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUESS4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 14:56:48 -0400
Received: from [68.184.155.122] ([68.184.155.122]:20461 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264502AbUESS4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 14:56:46 -0400
Date: Wed, 19 May 2004 14:56:23 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: uname problem in 2.6.6?
Message-ID: <20040519185623.GV6684@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OmL7C/BU0IhhC9Of"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OmL7C/BU0IhhC9Of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



I just installed a 2.6.6 kernel with no patches on a new machine:

root# uname -a
Linux build1 2.6.6 #2 SMP Wed May 19 14:27:59 EDT 2004 i686 unknown

root# uptime
Unknown HZ value! (91) Assume 100.
 14:54:22 up 1 min,  1 user,  load average: 0.30, 0.13, 0.05

on a different machine:

{0}uname -a
Linux wally 2.6.4-bk4 #4 SMP Tue Mar 30 09:41:14 EST 2004 i686 GNU/Linux

{0}uptime
 14:55:34 up 50 days,  1:06,  3 users,  load average: 0.00, 0.00, 0.00


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

With Dreams To Be A King First One Should Be A Man
					- Manowar


--OmL7C/BU0IhhC9Of
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAq63X8+1vMONE2jsRAgIUAJ9cjtiUgL6IvQ/WHB9482fMjUJq+wCeKWQE
2Xm3vmBJFZQLsQn2YCgI0ok=
=aqwY
-----END PGP SIGNATURE-----

--OmL7C/BU0IhhC9Of--
