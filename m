Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTDWPtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTDWPtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:49:17 -0400
Received: from h80ad26b0.async.vt.edu ([128.173.38.176]:20610 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264091AbTDWPsi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:48:38 -0400
Message-Id: <200304231600.h3NG0aCs019316@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68 kernel no initrd 
In-Reply-To: Your message of "Wed, 23 Apr 2003 15:49:54 +0200."
             <Pine.LNX.4.51L.0304231547460.12634@piorun.ds.pg.gda.pl> 
From: Valdis.Kletnieks@vt.edu
References: <000701c306f6$cf100180$0200a8c0@satellite> <1050859494.595.4.camel@teapot.felipe-alfaro.com>
            <Pine.LNX.4.51L.0304231547460.12634@piorun.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_980076719P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Apr 2003 12:00:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_980076719P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Apr 2003 15:49:54 +0200, =3D?ISO-8859-2?Q?Pawe=3DB3_Go=3DB3asz=
ewski?=3D said:
> initrd gives much more flexibility.
> I can make one kernel and use it on _all_ of my mashines, just change =

> initrd. quick, nice and flexible with proper initrd tools set.

Amen.  initrd isn't just for modules - I'd not need an initrd at all if I=
 could
figure out how to start up an LVM volume group from kernelspace - I suspe=
ct
people with / on a RAID disk have similar issues...


--==_Exmh_980076719P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+prijcC3lWbTT17ARAtZnAJ4mBqePRtbyQaYhfSEnUUaN7SQq7ACgzun2
GsPT3ddaRmF2Jh37zqNQ0T8=
=5Ypq
-----END PGP SIGNATURE-----

--==_Exmh_980076719P--
