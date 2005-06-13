Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVFMJyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFMJyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVFMJyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:54:53 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:9656 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261297AbVFMJys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:54:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] blkstat
Date: Mon, 13 Jun 2005 19:54:43 +1000
User-Agent: KMail/1.8.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
References: <42AD55FA.50109@yahoo.com.au>
In-Reply-To: <42AD55FA.50109@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1273160.YLlThnIQCB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506131954.45361.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1273160.YLlThnIQCB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 13 Jun 2005 19:46, Nick Piggin wrote:
> I have made a simple tool to measure idle and busy time for
> block devices.
>
> I have been wanting something like this for a while, because
> the absolute throughput/seek numbers don't always help you
> determine whether or not a workload is becoming IO bound.
>
> It requires a small kernel patch, and I've also attached my
> lame userspace program for it. It is kind of like vmstat.
>
> Oh, and before I go further, does anyone know of any program
> or statistic that allows the same functionality? Any comments?

Would something like iostat give similar results?

http://linux.inet.hr/

Cheers,
Con

--nextPart1273160.YLlThnIQCB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrVflZUg7+tp6mRURAkWNAJ9evfDE73N/wuavhV/PqpsEupc1fwCeO19s
UCM1ERIB1njQpoD/x6eSPoo=
=4SrQ
-----END PGP SIGNATURE-----

--nextPart1273160.YLlThnIQCB--
