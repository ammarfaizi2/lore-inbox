Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUGGPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUGGPrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUGGPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:47:40 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:53898 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264908AbUGGPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:47:35 -0400
Message-ID: <40EC1B0A.8090802@kolivas.org>
Date: Thu, 08 Jul 2004 01:47:22 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: Re: 2.6.7-ck5
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net>
In-Reply-To: <40EC1930.7010805@comcast.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9CCB896881A56EEE4B97511F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CCB896881A56EEE4B97511F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

John Richard Moser wrote:
> Very nice, Con.  I've been using ck1 and ck3 with pax applied, and
> finding performance to be exceptional.  I'll merge current 2.6.7-pax
> with this and test it out right away.

Great! The ck4 performance was actually substantially better than ck3 
(on the desktop) so here's hoping you enjoy ck5 which basically performs 
the same.

> 
> When do you think the staircase, batch, and isometric scheduling will
> reach mainline-quality?  Do you think you'll be ready to ask Andrew to
> merge it soon, or will it be a while before it's quite ready for that?

Well I think they're all ready for prime time now, I just dont think 
prime time is ready for it. This is too large a change for mainline 2.6 
which keeps -ck in business ;)

> How about autoregulated swappiness, which seems to be very efficient at
> its job?

It's been around for quite a while, and akpm has not expressed any 
interest in it so I think this will only ever flounder in the -ck domain.

Cheers,
Con

P.S. You seem to have preempted the arrival of my -ck5 announcement to 
lkml, as will this response. lkml does that sometimes...
P.P.S. It's "isochronous scheduling" :P Means "same time".

--------------enig9CCB896881A56EEE4B97511F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7BsMZUg7+tp6mRURArDDAJ4nEURB+CJ1L4EhUlFzMPmVbtdJ2gCgkNOT
qJs0EfOz18Evw6WB6Rn6YrU=
=6hBV
-----END PGP SIGNATURE-----

--------------enig9CCB896881A56EEE4B97511F--
