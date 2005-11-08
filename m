Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVKHHZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVKHHZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVKHHZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:25:37 -0500
Received: from admingilde.org ([213.95.32.146]:19346 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965023AbVKHHZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:25:37 -0500
Date: Tue, 8 Nov 2005 08:25:35 +0100
From: Martin Waitz <tali@admingilde.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
Message-ID: <20051108072535.GN9633@admingilde.org>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051107225408.911193000@admingilde.org> <20051107225604.841433000@admingilde.org> <20051107194044.1841277b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline
In-Reply-To: <20051107194044.1841277b.rdunlap@xenotime.net>
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
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 07, 2005 at 07:40:44PM -0800, Randy.Dunlap wrote:
> Just to be clear about the usage, the kernel-doc script switches from
> public to private upon seeing a /*-style comment with the strings
> "private:" or "public:" in it.  Right?

exactly.

For now I only changed those comments that already made it clear
what was private and public.  Feel free to add more private fields! :-)

--=20
Martin Waitz

--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcFLvj/Eaxd/oD7IRAgEBAJ9fb17SWxhCkuRWMEoNzmBLYizvuwCffy4B
2OveT4HvC0p2hXQEsv7zwpM=
=ihL9
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--
