Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVFMUaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVFMUaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFMU1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:27:07 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17929 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261324AbVFMUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:25:09 -0400
Message-Id: <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: =?ISO-8859-1?Q?Mattias Engdeg=E5rd?= <mattias@virtutech.se>
Cc: cfriesen@nortel.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, dwmw2@infradead.org,
       drepper@redhat.com
Subject: Re: Add pselect, ppoll system calls. 
In-Reply-To: Your message of "Mon, 13 Jun 2005 22:08:55 +0200."
             <200506132008.j5DK8t010817@virtutech.se> 
From: Valdis.Kletnieks@vt.edu
References: <200506131938.j5DJcKc10799@virtutech.se> <42ADE52E.1040705@nortel.com>
            <200506132008.j5DK8t010817@virtutech.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118694222_5914P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 16:23:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118694222_5914P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jun 2005 22:08:55 +0200, =3D?ISO-8859-1?Q?Mattias Engdeg=3DE5r=
d?=3D said:
> >Mattias Engdeg=E5rd wrote:

> >Absolute timestamps are messy though.  How do you deal with system tim=
e=20
> >changes?
>=20
> Monotonic clocks are there for exactly that, no?

Monotonic clocks are guaranteed to not go backward.  A sudden warp 35 sec=
onds
into the future when you have timers set for 15 and 20 seconds into the f=
uture
is still ugly....

--==_Exmh_1118694222_5914P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCretOcC3lWbTT17ARAgemAJ9FgUAmGdL+u7y1ChaHBozKbGHivgCgzV+p
ZLIcnvZhS7Atzr2KnGPQEEE=
=2vRV
-----END PGP SIGNATURE-----

--==_Exmh_1118694222_5914P--
