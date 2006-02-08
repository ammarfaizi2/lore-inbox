Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWBHVFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBHVFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWBHVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:05:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932446AbWBHVFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:05:01 -0500
Message-ID: <43EA5CCD.7030605@redhat.com>
Date: Wed, 08 Feb 2006 13:04:13 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Ulrich Drepper <drepper@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] fstatat64 support
References: <200602082008.k18K8dqE026598@devserv.devel.redhat.com> <20060208204015.GA25477@infradead.org>
In-Reply-To: <20060208204015.GA25477@infradead.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC4DE6277EAC4C5088B11E846"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4DE6277EAC4C5088B11E846
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig wrote:
> please remove the new from the syscall name.  just sys_fstatat64

I use that to show the lineage.  We use newfstat etc for the current
generation of interfaces.  Using fstatat would be irritating IMO.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigC4DE6277EAC4C5088B11E846
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD6lzN2ijCOnn/RHQRApADAJ9bsKg+wBM6H3er+rGH3MlmqJUrywCgxbj2
WnRsaz7x1aX2xtm1NeR+Zx4=
=AKt9
-----END PGP SIGNATURE-----

--------------enigC4DE6277EAC4C5088B11E846--
