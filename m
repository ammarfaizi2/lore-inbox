Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUIMNmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUIMNmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUIMNmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:42:45 -0400
Received: from smtp0.telegraaf.nl ([217.196.45.192]:5045 "EHLO
	smtp0.telegraaf.nl") by vger.kernel.org with ESMTP id S266748AbUIMNmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:42:23 -0400
Date: Mon, 13 Sep 2004 15:42:15 +0200
From: Roel van der Made <roel@telegraafnet.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040913134215.GY3951@telegraafnet.nl>
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu> <41456536.6090801@sw.ru> <20040913092443.GA19437@elte.hu> <20040913133437.GW3951@telegraafnet.nl> <20040913133847.GA9157@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mF+UrcnZFczIwKjY"
Content-Disposition: inline
In-Reply-To: <20040913133847.GA9157@elte.hu>
User-Agent: Mutt/1.5.3i
X-telegraaf-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mF+UrcnZFczIwKjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2004 at 03:38:47PM +0200, Ingo Molnar wrote:
> * Roel van der Made <roel@telegraafnet.nl> wrote:
> > > > the last check ensures that we are still hashed and this check is m=
ore=20
> > > > straithforward for understanding, agree?
> > > yep - please send a new patch to Andrew.
> > I'll be awaiting the patch and give it a shot.
> > Thanks all for the feedback.
> you can try my patch too, it will do the job of fixing the bug. The
> other changes we talked about are only improvements to the debugging
> infrastructure.

Saw there's an mm5 release already, is your patch included in this one
also?

> 	Ingo

--=20
Roel van der Made                             .--.
GNU/Linux Systems/Network Engineer           |o_o |
Telegraaf Media ICT - Internet Services      |:_/ |
Tel.: 020 585 2229                          //   \ \
GnuPG Key available at: http://roel.net/gpgkey.asc=20

--mF+UrcnZFczIwKjY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBRaO3PkMWyL8l9u8RAn+kAJ9oM+tGFixzoSW4h92DPBofHrNs7wCdG/5v
KyvYWx0aqL50ZrdOzuqGEQc=
=asXm
-----END PGP SIGNATURE-----

--mF+UrcnZFczIwKjY--
