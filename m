Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbUATUpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUATUpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:45:40 -0500
Received: from mcgroarty.net ([64.81.147.195]:38537 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S265644AbUATUph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:45:37 -0500
Date: Tue, 20 Jan 2004 14:45:37 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: HPT370 status [2.4/2.6]
Message-ID: <20040120204537.GA6820@mcgroarty.net>
References: <1g0ZG-2q6-15@gated-at.bofh.it> <400D72B5.40705@gmx.at> <yw1x4quqo1gx.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <yw1x4quqo1gx.fsf@ford.guide>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:
> Jan De Luyck wrote:
>> Hello List,
>> Before I start frying my disks and all, what's the usability status
>> of the Hightpoint HPT370 ide "raid" controller on linux 2.4 and 2.6?
>
> 2.4 is fine if you use the ataraid code. mirroring is not fault
> tolerant so you would not want to use that.

No problems with 2.4 here.

2.6 recognizes my 374, which uses the hpt366 driver like the
370. However, no devices are being made available from it [1].

If others' experiences are any different, I'd love to hear.


[1] http://lkml.org/lkml/2004/1/16/18

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADZNx2PBacobwYH4RAmNMAJ9cYR+iSutoVw5fdaTfWkinHk1RhACcDIi8
XoBY5Y4kR3Wn09oxa3d0TfU=
=dU/v
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
