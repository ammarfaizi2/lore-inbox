Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSJVUOv>; Tue, 22 Oct 2002 16:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264923AbSJVUNm>; Tue, 22 Oct 2002 16:13:42 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:45294 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264920AbSJVUMv>; Tue, 22 Oct 2002 16:12:51 -0400
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
From: Arjan van de Ven <arjanv@redhat.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <E1844h3-0002Bt-00@w-gerrit2>
References: <E1844h3-0002Bt-00@w-gerrit2>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-GKyZ6V7vR9aKSA43Rb9d"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:56:25 +0200
Message-Id: <1035316645.4690.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GKyZ6V7vR9aKSA43Rb9d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-22 at 21:27, Gerrit Huizenga wrote:
 be fine with me - we are only planning on people using
> flags to shm*() or mmap(), not on the syscalls.  I thought Oracle
> was the one heavily dependent on the icky syscalls.

the icky syscalls are unusable for databases.. I'd be *really* surprised
if oracle could use them at all on x86....


--=-GKyZ6V7vR9aKSA43Rb9d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ta1pxULwo51rQBIRAjPyAJ4pxKSVXHr4VTh2jlxXSRvp7zzEfQCeNlcB
Pd76DiFz8SX1wRaQUubJZzE=
=Ul4s
-----END PGP SIGNATURE-----

--=-GKyZ6V7vR9aKSA43Rb9d--

