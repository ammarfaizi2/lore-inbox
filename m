Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbUANJlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUANJi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:38:59 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:57472 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265461AbUANJfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:35:15 -0500
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jh@suse.cz
In-Reply-To: <20040114090603.GA1935@averell>
References: <20040114090603.GA1935@averell>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qWrF5y3AEEEW+AMJuLX2"
Organization: Red Hat, Inc.
Message-Id: <1074072899.4981.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 14 Jan 2004 10:34:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qWrF5y3AEEEW+AMJuLX2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-01-14 at 10:06, Andi Kleen wrote:

>=20
> According to some gcc developers it should be safe to use in all
> gccs that are still supports (2.95 and up)=20

it is not safe for the kernel until the cardbus CardServices patches get
merged (is in -mm), for the same reason CardServices() is broken on
amd64.



--=-qWrF5y3AEEEW+AMJuLX2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBABQ1CxULwo51rQBIRArc4AJwK5QCrbSb6ExWc8BfV3WRXdYO9bgCgqQCr
dEjRdqXEua/0s5HkgLLRpzY=
=0hb4
-----END PGP SIGNATURE-----

--=-qWrF5y3AEEEW+AMJuLX2--
