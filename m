Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbRFNIwX>; Thu, 14 Jun 2001 04:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRFNIwN>; Thu, 14 Jun 2001 04:52:13 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:11931 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261700AbRFNIwD>; Thu, 14 Jun 2001 04:52:03 -0400
Date: Thu, 14 Jun 2001 09:51:52 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Patrick Mochel <mochel@transmeta.com>
Cc: Jeff Golds <jgolds@resilience.com>, Keith Owens <kaos@ocs.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3
Message-ID: <20010614095152.Y13678@redhat.com>
In-Reply-To: <3B27DE0E.84025F41@resilience.com> <Pine.LNX.4.10.10106132305450.1433-100000@nobelium.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ABd7dauUP597Mpr3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106132305450.1433-100000@nobelium.transmeta.com>; from mochel@transmeta.com on Wed, Jun 13, 2001 at 11:39:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ABd7dauUP597Mpr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2001 at 11:39:49PM -0700, Patrick Mochel wrote:

> First off, the patch went into a pre-release of the kernel. Never would I
> trust a pre-release to be stable.

The issue is that of interface stability, as I'm sure you know.

> Second of all, if you look at the big picture, you may see the benefit in
> the change that was made. There is an effort to make Linux support power
> management, both at the system-wide level and at the driver level, in a
> much better way than it ever has. These changes are a manifestation of
> that effort.=20

I've no doubt that new and better functions were necessary: but
couldn't it have been done in a source-compatible way?  New functions
rather than changed ones?

> Thirdly, these functions are rarely used.

Not every single driver is in Linus' tree.

I didn't see a feature-test macro either: did I miss it?

Tim.
*/

--ABd7dauUP597Mpr3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7KHsnONXnILZ4yVIRApozAJsFUZITfdlOIgp2rsrFN1vZAY21cgCfej4c
ofSluA0hjpBtuvAvzueoA9k=
=RrFS
-----END PGP SIGNATURE-----

--ABd7dauUP597Mpr3--
