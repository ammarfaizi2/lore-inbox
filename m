Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTEMLCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 07:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTEMLCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 07:02:10 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:44528 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263479AbTEMLCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 07:02:09 -0400
Subject: Re: kernel BUG at inode.c:562!
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052823517.5022.3.camel@tor.trudheim.com>
References: <1052823517.5022.3.camel@tor.trudheim.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gDLLcMHT6S+uA3njMYnD"
Organization: Red Hat, Inc.
Message-Id: <1052824488.4699.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 May 2003 13:14:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gDLLcMHT6S+uA3njMYnD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-13 at 12:58, Anders Karlsson wrote:
> EIP:    0010:[<c01554da>]    Tainted: PF
> Using defaults from ksymoops -t elf32-i386 -a i386

which other modules were in use ?

--=-gDLLcMHT6S+uA3njMYnD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+wNOoxULwo51rQBIRAv/AAJ0XPkFIBQqtB01KxGBTDFH0T5B3gQCfSLgH
jDJfHDD6Gb3yMRxkS8nfhoc=
=gdwK
-----END PGP SIGNATURE-----

--=-gDLLcMHT6S+uA3njMYnD--
