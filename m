Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271703AbTHDLLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 07:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271704AbTHDLLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 07:11:12 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:65523 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S271703AbTHDLLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 07:11:11 -0400
Subject: Re: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon
	Image 3112 SATARaid, CMD680, etc?) for testing
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Thomas Horsten <thomas@horsten.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0308041242030.22732-100000@jehova.dsm.dk>
References: <Pine.LNX.4.40.0308041242030.22732-100000@jehova.dsm.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gtvx1sr92gNBniCFGmgS"
Organization: Red Hat, Inc.
Message-Id: <1059995461.5291.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 04 Aug 2003 13:11:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gtvx1sr92gNBniCFGmgS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-04 at 12:49, Thomas Horsten wrote:

> I was under the impression that silraid.c never worked at all (it
> certainly didn't on my system), because the magic number it looks for is
> incorrect (actually, part of the drive's serial number), and thus not
> present on all systems with this RAID).

well... that's a 1 line fix to silraid.c......


--=-Gtvx1sr92gNBniCFGmgS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Lj9FxULwo51rQBIRAr2hAKCH70Stp9W+Enju9qgiUxjPnCIhuACdFdNH
8nFTxUfLC13nm7lqrhUJXBQ=
=iNeQ
-----END PGP SIGNATURE-----

--=-Gtvx1sr92gNBniCFGmgS--
