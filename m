Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbUKMVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUKMVGq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKMVEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:04:44 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:40871 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261170AbUKMVDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:03:18 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: pwc driver status?
Date: Sat, 13 Nov 2004 22:03:32 +0100
User-Agent: KMail/1.7
Cc: Gergely Nagy <algernon@boszorka.mad.hu>,
       Gergely Nagy <algernon@bonehunter.rulez.org>
References: <200411132134.52872.lkml@kcore.org> <1100378556.16772.18.camel@melkor>
In-Reply-To: <1100378556.16772.18.camel@melkor>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3648606.LYjCx0Xzbb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411132203.32908.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3648606.LYjCx0Xzbb
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 13 November 2004 21:42, Gergely Nagy wrote:
> > There seems to be an 'official' driver, but that has been discontinued,
> > and now there seems to be an 'unofficial' one.
> >
> > Is there still a working driver for 2.4/2.6? What does it support?
>
> Luc Saillards driver for 2.6 supports all the official and now
> discontinued driver did, and some more. It's also licensed under the GPL
> so won't taint your kernel. For 2.4... I'd upgrade to 2.6 >;)
>

Unfortunately, upgrading is not an option right now for other reasons...

Is this driver also supporting the Logitech Quickcam for Notebooks? I found=
=20
some references that the 'official' one used to do that, but I can't find=20
much docs...=20

Jan
=2D-=20
BOFH excuse #245:

The Borg tried to assimilate your system. Resistance is futile.

--nextPart3648606.LYjCx0Xzbb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBlnakUQQOfidJUwQRAqJkAJ9IN5hw/Xeb3/D5Va1jOzZ9Ems2rwCdHWjf
E6UfCZb47eh9q7GxHvSijrM=
=JCXK
-----END PGP SIGNATURE-----

--nextPart3648606.LYjCx0Xzbb--
