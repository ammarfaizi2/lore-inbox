Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTJBE0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 00:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbTJBE0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 00:26:24 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:44488 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S263235AbTJBE0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 00:26:22 -0400
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: Dan Hollis <goemon@anime.net>, linux-kernel@vger.kernel.org
Subject: Re: problem with IDE TCQ on 2.6.0-test6
Date: Thu, 2 Oct 2003 06:25:45 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0310011659580.32373-100000@sasami.anime.net>
In-Reply-To: <Pine.LNX.4.44.0310011659580.32373-100000@sasami.anime.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Qj6e/SwxPZPYBJv";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310020625.52761.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Qj6e/SwxPZPYBJv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi List,
I just tried TCQ (hdparm -Q32) on a box with a IBM-DTLA-307030 and a=20
IC35L120AVVA07-0 and I see the same messages when I create heavy=20
reading-load.

On Thursday 02 October 2003 02:04, Dan Hollis wrote:
> We have a bunch of IC35L180AVV207-1 in raid1 configuration.
>
> If we enable IDE TCQ, we get a 'ide_dmaq_intr: stat=3D40, not expected'
> every few seconds. If TCQ is disabled, the messages are gone.
>
> Replies in private email, i'm not subscribed to the list.
>
> -Dan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-02=_Qj6e/SwxPZPYBJv
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/e6jQ4q3E2oMjYtURAsV2AKCmibnddkk7Y7g5/nGjf+o0Ijgk0gCgma0/
P7SVwajNIwpM5K1CPCXU/5I=
=Ea/X
-----END PGP SIGNATURE-----

--Boundary-02=_Qj6e/SwxPZPYBJv--

