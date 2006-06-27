Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWF0E2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWF0E2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932951AbWF0E2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:28:14 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:11406 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932106AbWF0E2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:28:13 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 14:28:08 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606262320.01535.rjw@sisk.pl>
In-Reply-To: <200606262320.01535.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11402682.aKDxspA6Oh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271428.11654.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart11402682.aKDxspA6Oh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > Add Suspend2 extent support. Extents are used for storing the lists
> > of blocks to which the image will be written, and are stored in the
> > image header for use at resume time.
>
> Could you please put all of the changes in kernel/power/extents.c into one
> patch? =C2=A0It's quite difficult to review them now, at least for me.

I spent a long time splitting them up because I was asked in previous=20
iterations to break them into manageable chunks. How about if I were to ema=
il=20
you the individual files off line, so as to not send the same amount again?

> Well, I think similar remarks will apply to the other series of patches
> too, so I won't repeat them if you don't mind.  [Also I won't be able to
> have a look at the other patches today.  I'll do my best to review them in
> the next couple of days.]

Thanks. No rush.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart11402682.aKDxspA6Oh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoLPbN0y+n1M3mo0RAhb6AJ4j4c6U8PdPWHOi8kz5EfciuoD5tACfeKEY
D3Hdw5yy6rSXQhh49zzOvE4=
=m+Fu
-----END PGP SIGNATURE-----

--nextPart11402682.aKDxspA6Oh--
