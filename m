Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUIPLml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUIPLml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267977AbUIPLma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:42:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267992AbUIPLls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:41:48 -0400
Subject: Re: [PATCH] Suspend2 merge: New exports.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: ncunningham@linuxmail.org
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095333619.3327.189.camel@laptop.cunninghams>
References: <1095333619.3327.189.camel@laptop.cunninghams>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FdkQ1gRz8p7n1kdyAumk"
Organization: Red Hat UK
Message-Id: <1095334846.2698.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 13:40:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FdkQ1gRz8p7n1kdyAumk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-16 at 13:20, Nigel Cunningham wrote:

> =20
> +EXPORT_SYMBOL(tainted);

uhhhhh why do you need this in a module ?????

most of these exports look REALLY fishy to me.


--=-FdkQ1gRz8p7n1kdyAumk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSXu+xULwo51rQBIRAtDvAJ9yNrdPbDY3e+CBnnzcpiRLTO6McQCeMirz
RundZ0dMecQ5yALPQhXx+Zw=
=H3HT
-----END PGP SIGNATURE-----

--=-FdkQ1gRz8p7n1kdyAumk--

