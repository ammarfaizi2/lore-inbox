Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWDUOwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWDUOwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWDUOwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:52:36 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:1229
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932340AbWDUOwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:52:35 -0400
From: Michael Buesch <mb@bu3sch.de>
To: mikado4vn@gmail.com
Subject: Re: [PATCH] Rename "swapper" to "idle"
Date: Fri, 21 Apr 2006 16:56:50 +0200
User-Agent: KMail/1.9.1
References: <000301c66503$3bbd8060$0200a8c0@nuitysystems.com> <4448EEE7.5010708@gmail.com>
In-Reply-To: <4448EEE7.5010708@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hua Zhong <hzhong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12876845.kjO37JbVYJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604211656.50485.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12876845.kjO37JbVYJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 21 April 2006 16:40, Mikado wrote:
> Hua Zhong wrote:
> > Swapper does not do these things. It just happens to be "running" at th=
at time (and it is always running if the system is idle).
> >
> > IOW, it is indeed an "idle" process. In fact, all it does is cpu_idle().
>=20
> Really? Are your sure that swapper only does cpu_idle()???

Yes.
Idle is by definition Nothing.

=2D-=20
Greetings Michael.

--nextPart12876845.kjO37JbVYJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBESPKylb09HEdWDKgRAmQSAJ461LsWMOqFChajyZtZZyKdrzJ3KwCeLvrG
P84bRkXqafYcefQZEH97qgI=
=xSHc
-----END PGP SIGNATURE-----

--nextPart12876845.kjO37JbVYJ--
