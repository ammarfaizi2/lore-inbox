Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUEALcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUEALcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 07:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUEALcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 07:32:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261451AbUEALcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 07:32:16 -0400
Subject: Re: get_user_pages question
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Eli Cohen <mlxk@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40938618.1090100@mellanox.co.il>
References: <40938618.1090100@mellanox.co.il>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KwcM11xgE5jqwwyrot4B"
Organization: Red Hat UK
Message-Id: <1083411131.3844.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 01 May 2004 13:32:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KwcM11xgE5jqwwyrot4B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Apparently some pages were discarded and the subsequent page fault=20
> brought a new page. I expected the original page to be in the swap cache=20
> and get the old page again. I repeated the experiment but before the=20
> first ioctl I wrote something to all the pages but got the same results.=20
> I used 2.4.21-4 (RH AS 3.0).

I still have grave doubts about what you try to do... is this the code
at openib.org ? or is there some other URL where the code is visible ?


--=-KwcM11xgE5jqwwyrot4B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAk4q5xULwo51rQBIRAn8UAJ45VOV0AqBiKXBUWgZcMpJRNVTpsACfd9uG
+9rR2eg79LTMO/TeeDicIME=
=urXj
-----END PGP SIGNATURE-----

--=-KwcM11xgE5jqwwyrot4B--

