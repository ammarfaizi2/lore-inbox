Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUE3AMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUE3AMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUE3AMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:12:21 -0400
Received: from 68-184-151-141.cpe.ga.charter.com ([68.184.151.141]:7614 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261321AbUE3AMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:12:19 -0400
Date: Sat, 29 May 2004 20:12:13 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ext3 probem in 2.4.25 with 4 procs?
Message-ID: <20040530001212.GI24213@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



  I've just built out a new system running 2.4.25.  It's an IBM with=20
Dual HT procs, thus showing 4 procs in /proc/cpuinfo.  On /usr which is=20
4 Gigs we've got a weird discrepency.  "du -h" and "df -h" report a 1=20
Gig difference.

There used to be a problem with 4procs and ext3.  Does that problem
still exist and can it be related to our odd filesystem reports?




:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

With Dreams To Be A King First One Should Be A Man
					- Manowar


--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAuSbc8+1vMONE2jsRApVQAKCGMU1L+hT2OqO2N6Nl7vDkZMjXeACg5rGU
rZgGgmBukTrV/Pn1NFOOZIY=
=Wy4F
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
