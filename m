Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTESRyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTESRyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:54:08 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:26870 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262591AbTESRyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:54:06 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: David Ford <david+cert@blue-labs.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3EC91B6D.9070308@blue-labs.org>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
	 <1053292339.10127.45.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
	 <1053341023.9152.64.camel@workshop.saharact.lan>
	 <20030519124539.B8868@infradead.org>  <3EC91B6D.9070308@blue-labs.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oiZzkaBikqCc4Hr0yO/T"
Organization: Red Hat, Inc.
Message-Id: <1053367592.1424.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 19 May 2003 20:06:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oiZzkaBikqCc4Hr0yO/T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-19 at 19:59, David Ford wrote:

> Someone please step up to the plate and explain how to convert kernel=20
> headers into sanitized headers for /usr/include.

It seems you totally miseed the entire point.
It shouldn't be an automatic conversion. It should be a well thought
subset cleaned from kernel private stuff.

I maintain such a subset for my employer and it's free for all to use
(it's GPL after all).=20

--=-oiZzkaBikqCc4Hr0yO/T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+yR0oxULwo51rQBIRAk2xAJsGdT98NDOXxiykwHFuB9d5ReJGNgCeINLd
A6jVPbyPZeqkBN+N2C/txqc=
=k1k2
-----END PGP SIGNATURE-----

--=-oiZzkaBikqCc4Hr0yO/T--
