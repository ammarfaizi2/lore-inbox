Return-Path: <linux-kernel-owner+w=401wt.eu-S964998AbXAJR4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbXAJR4M (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbXAJR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:56:12 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:57319 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964965AbXAJR4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:56:11 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash IDE chip under 2.6.18
Date: Wed, 10 Jan 2007 18:56:05 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <45A3FF32.1030905@wolfmountaingroup.com> <200701101829.32369.prakash@punnoor.de> <20070110174710.GL17267@csclub.uwaterloo.ca>
In-Reply-To: <20070110174710.GL17267@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1614920.XW5oHGJvpb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701101856.07137.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1614920.XW5oHGJvpb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 10 Januar 2007 18:47 schrieb Lennart Sorensen:
> On Wed, Jan 10, 2007 at 06:29:28PM +0100, Prakash Punnoor wrote:
> > You can install the Intel Matrix driver after "adjusting" the inf file.=
=2E.
>
> Hmm, I guess a good question is: Why should I have to edit the inf file?
> Is it an issue of them making it only install if your hardware is
> already set to ahci mode?  But how am I supposed to boot and install the
> driver until I have the driver installed then.  Well I might try that
> next time I go there.  How stupid of intel.

Intel wants you to buy hw with ICH8R. ICH8 isn't get the advanced features =
for=20
free....

To get the driver going: Put your hd to the jmicron, install driver, put hd=
=20
back to ich8...


=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1614920.XW5oHGJvpb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFpSi3xU2n/+9+t5gRAgpwAKCw6/CRDoboi1jkVE9i+7bwqqZDKQCdGVuu
48ce+/8x5B9+crFOq5H8U3M=
=XTGT
-----END PGP SIGNATURE-----

--nextPart1614920.XW5oHGJvpb--
