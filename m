Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUJRLSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUJRLSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 07:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJRLSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 07:18:25 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:62346 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266155AbUJRLSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 07:18:22 -0400
Date: Mon, 18 Oct 2004 13:18:11 +0200
From: Martin Waitz <tali@admingilde.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: rluethi@hellgate.ch, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.4 "makes pointer from integer without a cast" warnings in via-rhine-c
Message-ID: <20041018111811.GA3618@admingilde.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>, rluethi@hellgate.ch,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1097955967.2148.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <1097955967.2148.12.camel@krustophenia.net>
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Sat, Oct 16, 2004 at 03:46:07PM -0400, Lee Revell wrote:
> I get these warnings compiling via-rhine with gcc 3.4.  What is the
> correct way to fix this?  This came up in another thread and someone
> mentioned that just adding a cast is not a "real fix" but just hides the
> problem.

look at include/asm-generic/iomap.h

--=20
Martin Waitz

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBc5ydj/Eaxd/oD7IRAgnCAJ91DYe8/q26oW+16V/6Pq/2hEafZQCeMqOk
j9El4jGv+71rsqsoPe4hr0Q=
=NrcR
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
