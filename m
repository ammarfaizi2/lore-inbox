Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUBJQs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUBJQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:48:26 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:65152 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266008AbUBJQsY (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:48:24 -0500
Message-Id: <200402101647.i1AGlvrC006918@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Markus Gaugusch <markus@gaugusch.at>
Cc: David =?iso-8859-2?q?Posp=ED=B9il?= <foton2@post.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Security patch for 2.6.2 
In-Reply-To: Your message of "Tue, 10 Feb 2004 17:16:37 +0100."
             <Pine.LNX.4.58.0402101716070.7848@dynast.gaugusch.at> 
From: Valdis.Kletnieks@vt.edu
References: <200402101709.04825.foton2@post.cz>
            <Pine.LNX.4.58.0402101716070.7848@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1135267522P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Feb 2004 11:47:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1135267522P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2004 17:16:37 +0100, Markus Gaugusch said:
> On Feb 10, David Posp=ED=A8il <foton2@post.cz> wrote:
> =

> > Where can I find security patch for 2.6.2 ?
> > Problem : look at this site : http://www.securityfocus.com/archive/1/=
353217
> > It is remote root exploit :-(
> No, it is local root exploit. And the patch is attached to that posting=
=2E

Is the *real* problem here that smbfs doesn't understand the moral
equivalent of 'mount -o nosuid/nodev/noexec/no-etc'?

--==_Exmh_-1135267522P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKQs9cC3lWbTT17ARAtJQAJ4/dBsZUdU3RIE0a7F8zrML1Rs2oQCguL+B
5aaYhlHy2P9QV9NDf4evrRI=
=Hqrt
-----END PGP SIGNATURE-----

--==_Exmh_-1135267522P--
