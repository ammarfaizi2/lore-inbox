Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbTANQl6>; Tue, 14 Jan 2003 11:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTANQl6>; Tue, 14 Jan 2003 11:41:58 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26863 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S262877AbTANQl5>; Tue, 14 Jan 2003 11:41:57 -0500
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tigran Aivazian <tigran@veritas.com>
Cc: Christoph Hellwig <hch@lst.de>, Hugh Dickins <hugh@veritas.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0301141625580.1241-100000@einstein31.homenet>
References: <Pine.LNX.4.33.0301141625580.1241-100000@einstein31.homenet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m2tKSjvv6Xm14sOVwww3"
Organization: Red Hat, Inc.
Message-Id: <1042563017.1401.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 14 Jan 2003 17:50:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m2tKSjvv6Xm14sOVwww3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-01-14 at 17:32, Tigran Aivazian wrote:

> If you move it all the way to sysfs (i.e. no device node in /dev) then it
> seems a bit odd that a device driver entry point is found somewhere other
> than the usual /dev.

well

cat firmware > /sys/processor/0/microcode

is obviously the ultimate interface for this ;)

--=-m2tKSjvv6Xm14sOVwww3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+JD/JxULwo51rQBIRAroMAJ47W4A84gT88PDZZPrNsLB+r8eQogCaAnrG
miHZbaX61d1xIlmFqRFpvl4=
=Tj7X
-----END PGP SIGNATURE-----

--=-m2tKSjvv6Xm14sOVwww3--
