Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTDYIwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 04:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTDYIwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 04:52:50 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:23022 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263227AbTDYIwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 04:52:49 -0400
Subject: Re: 2.5.67-mm4 & IRQ balancing
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030424173025.11734A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030424173025.11734A-100000@gatekeeper.tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wtMHMoUaiZYlgUGxWFi7"
Organization: Red Hat, Inc.
Message-Id: <1051261420.1391.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 25 Apr 2003 11:03:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wtMHMoUaiZYlgUGxWFi7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-04-24 at 23:32, Bill Davidsen wrote:
>  And everybody can write one and try to measure the difference it
> makes.

I welcome this; however if you want to be lazy; the irqbalanced I wrote
has the policy separated from the infrastructure so it's relatively easy
to play with just that ;)

--=-wtMHMoUaiZYlgUGxWFi7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+qPnsxULwo51rQBIRAnWNAJ9CwhvEm8TBT+jkynUqBKMAPboBcwCcDH60
k7rDvyxLYHk5Ft1BjIGtN0o=
=jnQ6
-----END PGP SIGNATURE-----

--=-wtMHMoUaiZYlgUGxWFi7--
