Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUFIGU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUFIGU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 02:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265551AbUFIGU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 02:20:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40593 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265545AbUFIGU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 02:20:56 -0400
Subject: Re: [RFC][PATCH] ALSA: Remove subsystem-specific malloc (0/8)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <200406082124.i58LOrMm016152@melkki.cs.helsinki.fi>
References: <200406082124.i58LOrMm016152@melkki.cs.helsinki.fi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KkMHCPzgPMUZ/eJ/LFvL"
Organization: Red Hat UK
Message-Id: <1086762046.2810.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Jun 2004 08:20:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KkMHCPzgPMUZ/eJ/LFvL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-08 at 23:24, Pekka J Enberg wrote:
> This patch introduces a kcalloc()=20

too bad you didn't make kcalloc an array allocator, which then could
check for multiplication overfow nicely.....

--=-KkMHCPzgPMUZ/eJ/LFvL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAxqw+xULwo51rQBIRAg1vAJwO2fWtTfKcqjolJbDwwpU/37UKdACeJvCM
cq1W+rPerG5IlSInMhAg3f0=
=bAW1
-----END PGP SIGNATURE-----

--=-KkMHCPzgPMUZ/eJ/LFvL--

