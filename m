Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVACQMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVACQMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVACQMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:12:51 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:62684 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261491AbVACQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:12:42 -0500
Date: Mon, 3 Jan 2005 17:12:34 +0100
From: Martin Waitz <tali@admingilde.org>
To: tony osborne <tonyosborne_a@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Main CPU- I/O CPU interaction
Message-ID: <20050103161234.GZ31835@admingilde.org>
Mail-Followup-To: tony osborne <tonyosborne_a@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4hmTAJAngH+SZkLl"
Content-Disposition: inline
In-Reply-To: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4hmTAJAngH+SZkLl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 03, 2005 at 12:44:36AM +0000, tony osborne wrote:
> The I/O devices are equipped with dedicated processor to free the  main C=
PU=20
> from doing the low level I/O operations. However, if i am editing and=20
                 ^^^^^^^^^^^^^
> updating a big size file and i want to save
> it afterwards, i  notice my PC getting blocked while saving the file whic=
h=20
> theoritically should NOT happen as it is up to the I/O device processor a=
nd=20
> not the main CPU to save the data into the disk; the main CPU could switc=
h=20
> to another process after giving the high level command -save-to the devic=
e=20
                                      ^^^^^^^^^^^^^^^^^^
> processor; so why the main CPU is blocked while saving such big size files

--=20
Martin Waitz

--4hmTAJAngH+SZkLl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB2W7yj/Eaxd/oD7IRAgt8AJ4mnDnVplLaIOpR/t5ztZf9JYbdNQCcCkwU
5BeC+y1oNF0g7UbcACXqDoQ=
=jTKB
-----END PGP SIGNATURE-----

--4hmTAJAngH+SZkLl--
