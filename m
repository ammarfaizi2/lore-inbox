Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbTGHLOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGHLOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:14:06 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:17904 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265043AbTGHLNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:13:38 -0400
Subject: Re: [Ext2-devel] [RFC] parallel directory operations
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <87wuetukpa.fsf@gw.home.net>
References: <87wuetukpa.fsf@gw.home.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-inhNwRN5Pe1r7uI8XuPl"
Organization: Red Hat, Inc.
Message-Id: <1057663677.1959.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 08 Jul 2003 13:27:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-inhNwRN5Pe1r7uI8XuPl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-08 at 17:01, Alex Tomas wrote:
> I use dynamic locks

dynamic locks doesn't really look like a name that matches what it
does.. how about "spinarecuphore" ?

--=-inhNwRN5Pe1r7uI8XuPl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Cqq9xULwo51rQBIRAgWwAKCp3l+8EWOem/gYCChs+Zlm3CK29ACfTVre
WOwynZEPzPpwWUiNLIdFAyQ=
=Pfsl
-----END PGP SIGNATURE-----

--=-inhNwRN5Pe1r7uI8XuPl--
