Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUI0IJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUI0IJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 04:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUI0IJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 04:09:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4745 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266236AbUI0IJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 04:09:38 -0400
Subject: Re: heap-stack-gap for 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040925162252.GN3309@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D/F8/s+kTYoBS42wFLc2"
Organization: Red Hat UK
Message-Id: <1096272553.6572.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 10:09:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D/F8/s+kTYoBS42wFLc2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I didn't check the topdown model, in theory it should be extended to
> cover that too, this is only working for the legacy model right now
> because those apps aren't going to use topdown anyways.

which "those apps" ?
The topdown model is used by default for all applications....
(exceptions being those started with setarch -L or when the sysadmin
sets the /proc tunable to legacy)

--=-D/F8/s+kTYoBS42wFLc2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBV8qpxULwo51rQBIRAr6AAJ9rOjqqSOJVaATXiPuDV1bqX5YC7ACgorUW
pLZup2k4Rr7WsZG6OuZbtOs=
=OJAD
-----END PGP SIGNATURE-----

--=-D/F8/s+kTYoBS42wFLc2--

