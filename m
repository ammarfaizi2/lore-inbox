Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUIYKKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUIYKKe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 06:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269300AbUIYKKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 06:10:34 -0400
Received: from reptilian.maxnet.nu ([212.209.142.131]:48911 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S269299AbUIYKK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 06:10:29 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Date: Sat, 25 Sep 2004 12:08:57 +0200
User-Agent: KMail/1.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409230123.30858.thomas@habets.pp.se> <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain>
In-Reply-To: <1096060549.10797.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3831274.3VeNntWF00";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409251209.05807.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3831274.3VeNntWF00
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Once upon a midnight dreary, Alan Cox pondered, weak and weary:
> > And also, I'd like to see how a misbehaving airline passenger could start
> > to gain weight not originally on the plane, causing the flight attendants
> > to start executing people because of OOF. And IIRC most airlines don't
> > like having women onboard who are way too pregnant, so no forking either.
> The zero over commit code makes sure that we have enough swap/memory

I was talking about the simile.

---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;

--nextPart3831274.3VeNntWF00
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBVUPBKGrpCq1I6FQRAr8bAKDF1aHFqDgKqzlvYKI3NYzVqVTy6gCgjTpQ
c7Do/sYsr0+M0oivJaPFmNE=
=10bt
-----END PGP SIGNATURE-----

--nextPart3831274.3VeNntWF00--
