Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbTC2XsK>; Sat, 29 Mar 2003 18:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTC2XsK>; Sat, 29 Mar 2003 18:48:10 -0500
Received: from [200.43.253.26] ([200.43.253.26]:61616 "EHLO smtp.bensa.ar")
	by vger.kernel.org with ESMTP id <S261349AbTC2XsI>;
	Sat, 29 Mar 2003 18:48:08 -0500
From: Norberto BENSA <nbensa@gmx.net>
Reply-To: nbensa@yahoo.com
Organization: BENSA.ar
To: Hermann Himmelbauer <dusty@violin.dyndns.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem burning with ATAPI cd-rw
Date: Sat, 29 Mar 2003 20:59:13 -0300
User-Agent: KMail/1.5
References: <200303291907.38188.nbensa@gmx.net> <200303300007.58371.dusty@violin.dyndns.org>
In-Reply-To: <200303300007.58371.dusty@violin.dyndns.org>
X-GPG-KEY: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x49664BBE
X-OS: Gentoo GNU/Linux 1.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_UNjh+eTWy2ZQddU";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303292059.16456.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_UNjh+eTWy2ZQddU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

On Saturday 29 March 2003 08:07 pm, Hermann Himmelbauer wrote:
> When do these errors occur while burning? At the start or somewhere in the
> middle?

At start. It wants to burn but instead it inmediately fixates the CD.

> I had LOTS of troubles writing CD's, but every time it was due to
> incompatible Media. So - did you besides changing the glibc also change
> your CD-Media?

Yes, but I've tried old media too: same result.


> Moreover I somehow wonder - don't you use the ide-scsi module? Which
> program are you using for writing your CDs?

cdrecord 2.0 does atapi.


Regards,
Norberto

--Boundary-02=_UNjh+eTWy2ZQddU
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+hjNUFXVF50lmS74RAoqJAJ9rYcq7f+C9x4I4UrVxVGYIWOeM5wCfRVNJ
O1mY8hX/el/qXWVtQ7t1Duw=
=AAbA
-----END PGP SIGNATURE-----

--Boundary-02=_UNjh+eTWy2ZQddU--

