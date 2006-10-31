Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423067AbWJaKQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423067AbWJaKQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423075AbWJaKQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:16:17 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:16338 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1423067AbWJaKQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:16:17 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: nkalmala <nkalmala@gmail.com>
Subject: Re: [patch]trivial: un-needed add-store operation wastes a few bytes
Date: Tue, 31 Oct 2006 11:01:55 +0100
User-Agent: KMail/1.9.5
Cc: trivial@kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <45469F2D.9030602@gmail.com>
In-Reply-To: <45469F2D.9030602@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2752038.RB4LgW9m7H";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610311101.56011.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2752038.RB4LgW9m7H
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

nkalmala wrote:
> Un-needed add-store operation wastes a few bytes.
> 8 bytes wasted with -O2, on a ppc.
>
> Signed-off-by: nkalmala <nkalmala@gmail.com>

Documentation/SubmittingPatches:

using your real name (sorry, no pseudonyms or anonymous contributions.)

Greetings,

Eike

--nextPart2752038.RB4LgW9m7H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFRx8TXKSJPmm5/E4RApXkAJ9zDJ0PDDe5ISUzhh1moVd7MnW72ACePws1
uUf+Qrjhw4bWHZiuKbLmpDg=
=/yjF
-----END PGP SIGNATURE-----

--nextPart2752038.RB4LgW9m7H--
