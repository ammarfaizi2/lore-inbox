Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTD3JZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTD3JZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 05:25:22 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:36846 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261808AbTD3JZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 05:25:21 -0400
Subject: Re: RHAS kernel upgrade?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Yang-Hwee TAN <tanyh@bii-sg.org>
Cc: venom@sns.it, linux-kernel@vger.kernel.org
In-Reply-To: <1209.192.168.122.46.1051695018.squirrel@web.bii.a-star.edu.sg>
References: <1188.192.168.122.46.1051694168.squirrel@web.bii.a-star.edu.sg>
	 <Pine.LNX.4.43.0304301125360.5028-100000@cibs9.sns.it>
	 <1209.192.168.122.46.1051695018.squirrel@web.bii.a-star.edu.sg>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QCg6qhtCQjFi01E3NlpX"
Organization: Red Hat, Inc.
Message-Id: <1051695450.1408.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 30 Apr 2003 11:37:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QCg6qhtCQjFi01E3NlpX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-04-30 at 11:30, Yang-Hwee TAN wrote:
> looking at the rhas kernel src rpm, there's alot of patches
> made into the kernel, i'm not sure if i use the plain vanilla
> kernel tarball would i disable some kernel options and
> "cripple" any of the RH's advance server's functionality(s).
>=20
> has anyone use RHAS in a cluster environment with manual
> upgrading of kernel to perhaps 2.4.20, and everything goes
> well on the AS functionalities/add-ons?

well you will miss some of the cluster stuff; afaik IPVS isn't merged in
2.4.20 yet.


--=-QCg6qhtCQjFi01E3NlpX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+r5laxULwo51rQBIRAgIgAJ9kUEG21nwLzwlIHesR6kO0YmNOOgCbBoa3
0aLQZhENzGA3uf5joASUiZI=
=HxHG
-----END PGP SIGNATURE-----

--=-QCg6qhtCQjFi01E3NlpX--
