Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290417AbSBKUvN>; Mon, 11 Feb 2002 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290377AbSBKUvC>; Mon, 11 Feb 2002 15:51:02 -0500
Received: from monster.nni.com ([216.107.0.51]:273 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S290417AbSBKUuz>;
	Mon, 11 Feb 2002 15:50:55 -0500
Date: Mon, 11 Feb 2002 08:44:26 -0500
From: Andrew Rodland <arodland@noln.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap based VM 12e
Message-Id: <20020211084426.21907cfb.arodland@noln.com>
In-Reply-To: <Pine.LNX.4.33L.0202110012460.12554-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202110012460.12554-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.7.0claws44 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: yuSM.z0$PasG_!+)P;ugu5P+@#JEocHIpArGcQZ^hcGos8:DBJ-tfTQYWyf`$2r0vfaoo7F|h.;Agl'@x8v]?{#ZLQDqSB:L^6RXGfF_fD+G9$c:)p<yycF[Da]*=*
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.nImD5wfiUiLo6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.nImD5wfiUiLo6D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Feb 2002 00:15:24 -0200 (BRST)
Rik van Riel <riel@conectiva.com.br> wrote:

> The fifth maintenance release of the 12th version of the reverse
> mapping based VM is now available.

I don't have any evil benchmarks to run, but it works just great on my
little laptop (192mb ram, 73mb swap). The O(1)-K3 patch against 12c also
applies fine, and does the right thing.

This is cool-beans stuff. Makes me glad that I'm just a bit adventurous.
Not adventurous enough for 2.5, but I'm running 2.4.17+rmap12e+O(1)K3
and CML2 and etc.
--=.nImD5wfiUiLo6D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8Z8q9k/Qfd5whuDYRAoY8AJ99MjA+5PIAWBcaOtZtDkyubQ7n8QCcD1C3
15e2ZxuJ3ngnmWPUineO5/o=
=EktB
-----END PGP SIGNATURE-----

--=.nImD5wfiUiLo6D--

