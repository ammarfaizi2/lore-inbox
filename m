Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUCLKNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUCLKNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:13:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261531AbUCLKM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:12:59 -0500
Subject: Re: 2.6.4-mm1: unknown symbols cauased by
	remove-more-KERNEL_SYSCALLS.patch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, bunk@fs.tum.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040312014809.4f2b280e.akpm@osdl.org>
References: <20040310233140.3ce99610.akpm@osdl.org>
	 <200403121014.40889.arnd@arndb.de> <20040312012942.5fd30052.akpm@osdl.org>
	 <200403121035.02977.arnd@arndb.de>  <20040312014809.4f2b280e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OXOIujCleHbFePy0mNTK"
Organization: Red Hat, Inc.
Message-Id: <1079086310.4445.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 12 Mar 2004 11:11:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OXOIujCleHbFePy0mNTK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-03-12 at 10:48, Andrew Morton wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:

> But then the removal of KERNEL_SYSCALLS becomes hostage to those drivers,
> and nobody is working on them.   It'll never happen.

CONFIG_BROKEN ??

--=-OXOIujCleHbFePy0mNTK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAUYzmxULwo51rQBIRAlJKAJ9FX2HNrEjZ74O89Hqj7MqJfTw94wCdElWr
V6FTKCRYe7eN/sd+lCKl/0k=
=flvs
-----END PGP SIGNATURE-----

--=-OXOIujCleHbFePy0mNTK--

