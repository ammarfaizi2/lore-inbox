Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269688AbUJGOa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbUJGOa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbUJGOat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:30:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16835 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269738AbUJGO3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:29:44 -0400
Subject: Re: PCI Burst and Overall System Speed (XEON)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E350193E2@constellation.doubledimension.com>
References: <E6456D527ABC5B4DBD1119A9FB461E350193E2@constellation.doubledimension.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iaLaYGtc8NJxVOOH+sQL"
Organization: Red Hat UK
Message-Id: <1097159380.2789.28.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 16:29:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iaLaYGtc8NJxVOOH+sQL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-10-07 at 16:12, Brian McGrew wrote:
> I have a question about the PCI Bursting and overall processing speed on =
a dual Xeon box; but first I have to give a slight bit of background, (all =
of it relevant to the question) I'll try and keep it short.


can you try adding "idle=3Dpoll" to the kernel commandline ?


--=-iaLaYGtc8NJxVOOH+sQL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBZVLTpv2rCoFn+CIRAk5DAJ9G2ZOZkbna/1h6KDxI8JCX8wBhlgCfa4/Z
LAHC4qZ6VTIClehc9lJVbZs=
=atTB
-----END PGP SIGNATURE-----

--=-iaLaYGtc8NJxVOOH+sQL--

