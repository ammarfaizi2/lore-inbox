Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWCAV3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWCAV3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbWCAV3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:29:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:28896 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751918AbWCAV3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:29:09 -0500
Subject: Re: [PATCH] leave APIC code inactive by default on i386
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20060301043353.GJ28434@redhat.com>
References: <43D03AF0.3040703@us.ibm.com>
	 <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
	 <20060301043353.GJ28434@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tCoX2Q3ki9OSvwgQMJtO"
Date: Wed, 01 Mar 2006 13:29:06 -0800
Message-Id: <1141248546.30185.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tCoX2Q3ki9OSvwgQMJtO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-02-28 at 23:33 -0500, Dave Jones wrote:

> It's still being kicked around.  I saw one patch off-list earlier this
> week that has some small improvements over the variant originally posted,
> but still had 1-2 kinks.

Hm... what kinks are you referring to?  Anything you want me to look at?

--D

--=-tCoX2Q3ki9OSvwgQMJtO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEBhIia6vRYYgWQuURAtUpAJ0QJ9TrlcKru/9E6bXxwkfE3wyE0wCfSYTW
r8FZ2h+cPH8qoZD1NdQ9UvY=
=t2Sx
-----END PGP SIGNATURE-----

--=-tCoX2Q3ki9OSvwgQMJtO--

