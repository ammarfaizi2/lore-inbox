Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUJOHar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUJOHar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 03:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUJOHaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 03:30:46 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:4235 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266465AbUJOH35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 03:29:57 -0400
Date: Fri, 15 Oct 2004 09:29:39 +0200
From: Martin Waitz <tali@admingilde.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RESEND][PATCH 5/6] Provide a filesystem-specific sync'able page bit
Message-ID: <20041015072939.GK4072@admingilde.org>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
References: <24461.1097780707@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j3olVFx0FsM75XyV"
Content-Disposition: inline
In-Reply-To: <24461.1097780707@redhat.com>
User-Agent: Mutt/1.3.28i
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--j3olVFx0FsM75XyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Thu, Oct 14, 2004 at 08:05:07PM +0100, David Howells wrote:
> +#define PG_fs_misc		 9	/* Filesystem specific bit */

name it PG_fs_private if it is intended to be used by the fs only?

--=20
Martin Waitz

--j3olVFx0FsM75XyV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBb3xij/Eaxd/oD7IRArWgAJ44hzBW6p61XUuDx/B2ITDa0uGpAgCeOP3r
CUZikRkRnhfOu/C/+jf1i1U=
=Y7di
-----END PGP SIGNATURE-----

--j3olVFx0FsM75XyV--
