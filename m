Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271388AbTHMFns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 01:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTHMFns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 01:43:48 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:63962 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S271388AbTHMFnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 01:43:47 -0400
Date: Wed, 13 Aug 2003 17:43:38 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: gene.heskett@verizon.net
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <98750000.1060753418@ijir>
In-Reply-To: <200308130124.31978.gene.heskett@verizon.net>
References: <200308050207.18096.kernel@kolivas.org>
 <200308122307.22813.gene.heskett@verizon.net>
 <3F39AF78.1030903@cyberone.com.au>
 <200308130124.31978.gene.heskett@verizon.net>
X-Mailer: Mulberry/3.1.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========1783562778=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1783562778==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



--On Wednesday, August 13, 2003 01:24:31 AM -0400 Gene Heskett=20
<gene.heskett@verizon.net> wrote:


> Unrelated question:  I've applied the 2.6 patches someone pointed me
> at to the nvidia-linux-4496-pkg2 after figuring out how to get it to
> unpack and leave itself behind, so x can be run on 2.6 now.  But its
> a 100% total crash to exit x by any method when using it that way.
>
> Has the patch been updated in the last couple of weeks to prevent that
> now?  It takes nearly half an hour to e2fsck a hundred gigs worth of
> drives, and its going to bite me if I don't let the system settle
> before I crash it to reboot, finishing the reboot with the hardware
> reset button.
>
> Better yet, a fresh pointer to that site.
>

http://www.minion.de/

Works fine for me, as of 2.6.0-test1 (which is when I downloaded the=20
patch).  I don't get the crash on either of my systems (GeForce2Go P3=20
laptop and GeForce4 Athlon desktop).

Andrew
--==========1783562778==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/OdANHamGxvX4LwIRAvwZAKDmOU+HqTHNAo2muqTudu1QEDpgxgCgzWQ1
yiZyBXLTU01L8/RdWzxlg9Q=
=qAEz
-----END PGP SIGNATURE-----

--==========1783562778==========--

