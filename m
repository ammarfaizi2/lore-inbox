Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbUKWGjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUKWGjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbUKWGjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:39:47 -0500
Received: from dialpool1-94.dial.tijd.com ([62.112.10.94]:30592 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262195AbUKWGgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:36:40 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
Date: Tue, 23 Nov 2004 07:36:32 +0100
User-Agent: KMail/1.7.1
Cc: Eric Sandeen <sandeen@sgi.com>, linux-xfs@oss.sgi.com
References: <200411221530.30325.lkml@kcore.org> <41A27784.70505@sgi.com>
In-Reply-To: <41A27784.70505@sgi.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart18057779.UHHbBsppzQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411230736.36106.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart18057779.UHHbBsppzQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 23 November 2004 00:34, Eric Sandeen wrote:
> The trigger was a bad magic number related to directories... hard to say
> what happened in the first place.  Can you send the output from
> xfs_repair, that might offer some hints.

Sorry, but as a repair was very urgent, I didn't really think of saving the=
=20
xfs_repair output.. My bad I guess.

Jan

=2D-=20
The seven year itch comes from fooling around during the fourth, fifth,
and sixth years.

--nextPart18057779.UHHbBsppzQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBotp0UQQOfidJUwQRAroHAJ9PVu61ukGBeK9fC1jAo1I+7/4qlACfWH1M
FETWXeiD2T0YLezrEKE4HLs=
=46YF
-----END PGP SIGNATURE-----

--nextPart18057779.UHHbBsppzQ--
