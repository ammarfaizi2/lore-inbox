Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWGSJol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWGSJol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWGSJol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:44:41 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:42148 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S964775AbWGSJok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:44:40 -0400
From: Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: procfs and privacy and a few other questions
Date: Wed, 19 Jul 2006 11:44:20 +0200
User-Agent: KMail/1.9.1
References: <200607190020.29684.Wolfgang.Draxinger@campus.lmu.de> <200607190125.13192.Wolfgang.Draxinger@campus.lmu.de> <20060718235219.GB6815@martell.zuzino.mipt.ru>
In-Reply-To: <20060718235219.GB6815@martell.zuzino.mipt.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1209906.7tpXTdF8pG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607191144.30007.Wolfgang.Draxinger@campus.lmu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1209906.7tpXTdF8pG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 19. Juli 2006 01:52 schrieb Alexey Dobriyan:

> Copying to userspace with interrupts disabled is a really stupid
> idea. BTW, scinti_hist_dev_read won't even compile due to missing
> irq_flags. ;-)

Oops, seems I uploaded "that one"* version, LOL. Give me a couple of=20
hours to get to the development machine. What I got here is an very=20
old stage of the code, I don't know, why that bad locking happens=20
there. Until then I chmod 600 the one on my webspace

* funny story, but not the right place to tell here.

Wolfgang Draxinger

--nextPart1209906.7tpXTdF8pG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEvf79BfWmRR/TvT4RAuo4AJ47DR9qXtVfd0tkKlZWp1bbEVXnDgCgpLrN
T20Fca9I/Ld0b+GSKuJnSnY=
=hw4e
-----END PGP SIGNATURE-----

--nextPart1209906.7tpXTdF8pG--
