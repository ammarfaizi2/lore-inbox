Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276004AbSIVBmC>; Sat, 21 Sep 2002 21:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276042AbSIVBmC>; Sat, 21 Sep 2002 21:42:02 -0400
Received: from h24-68-71-10.vc.shawcable.net ([24.68.71.10]:33797 "EHLO
	kruhftwerk.dyndns.org") by vger.kernel.org with ESMTP
	id <S276004AbSIVBmB>; Sat, 21 Sep 2002 21:42:01 -0400
Date: Sat, 21 Sep 2002 18:47:09 -0700
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: boot kernel panic with 2.5.37
Message-ID: <20020922014709.GA8035@kruhft.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.19-gentoo-r9 
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After solving the kernel compile problem earlier i tried to actually
run it and got a kernel panic which consisted of the following:

<-- snip a bunch of stuff that i didn't write down but similar to the
following line -->

[<C0228EDA>] [<C0227F49>]

Code: 89 42 04 89 10 68 01 00 00 00 c7 03 00 00 00 c7 43 04 00

<0> Kernel Panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

<-- end of output -->

I sent my kernel config in an earlier message today (subject Re:
problems building bzImage with 2.5.*) for those that need to see it.

burton
--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jSEcLq/0KC7fYbURAjLVAJ4ztpE7bAXQ8tymvlg3Be/zs0X5iwCfamjA
GoYICtsl621qWfJQJZKLJi4=
=45ug
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
