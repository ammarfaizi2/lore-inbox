Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUASQnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 11:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUASQnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 11:43:40 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:27526 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265658AbUASQnj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 11:43:39 -0500
Subject: Re: 2.6.1-mm4: ALSA es1968 DMA alloc problem
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org
In-Reply-To: <s5hwu7n6gvz.wl@alsa2.suse.de>
References: <20040117161013.GA3303@convergence.de>
	 <s5hwu7n6gvz.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jttvGA/O4gqW386177PC"
Organization: Red Hat, Inc.
Message-Id: <1074530601.4443.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Jan 2004 17:43:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jttvGA/O4gqW386177PC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-19 at 17:29, Takashi Iwai wrote:
> At Sat, 17 Jan 2004 17:10:13 +0100,


all throughout the patch:
pci_set_dma_mask() and friends need their return value checked!


--=-jttvGA/O4gqW386177PC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBADAkpxULwo51rQBIRAuHYAJ9LXxx7u7+EneQyNR8nbX7qoZttbQCghSjM
xZtYE4J4lLyRFm8eG8jhD70=
=ApC5
-----END PGP SIGNATURE-----

--=-jttvGA/O4gqW386177PC--
