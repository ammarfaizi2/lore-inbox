Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVEDNtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVEDNtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVEDNtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:49:43 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:5561 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261830AbVEDNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:49:36 -0400
Date: Wed, 4 May 2005 15:47:17 +0200
From: Martin Waitz <tali@admingilde.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050504134717.GD3562@admingilde.org>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@gmail.com, smfrench@austin.rr.com, hch@infradead.org
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81cS/AQiHTJECVaz"
Content-Disposition: inline
In-Reply-To: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
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


--81cS/AQiHTJECVaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, May 03, 2005 at 04:31:35PM +0200, Miklos Szeredi wrote:
> This (lightly tested) patch against 2.6.12-rc* adds some
> infrastructure and basic functionality for unprivileged mount/umount
> system calls.

most of this unprivileged mount policy can be handled by a suid
userspace helper (e.g. pmount)

what are the pros/cons of handling that in the kernel?

--=20
Martin Waitz

--81cS/AQiHTJECVaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCeNJlj/Eaxd/oD7IRAi6rAJ4pPLJv2jbjJqvcBhcsvY4yrARmCQCeOUm8
os3F8qeMZOIdKx121zdinWU=
=LVn/
-----END PGP SIGNATURE-----

--81cS/AQiHTJECVaz--
