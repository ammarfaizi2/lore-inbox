Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUEVIYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUEVIYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUEVIYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:24:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32726 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264914AbUEVIYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:24:32 -0400
Subject: Re: [PATCH] ext3 barrier bits
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Chris Mason <mason@suse.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040522011139.01a7da10.akpm@osdl.org>
References: <20040521093207.GA1952@suse.de>
	 <20040521023807.0de63c7a.akpm@osdl.org> <20040521100234.GK1952@suse.de>
	 <20040521235044.6160cccb.akpm@osdl.org> <20040522073540.GO1952@suse.de>
	 <20040522011139.01a7da10.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GX4eE1tot+VHsSoaQcIg"
Organization: Red Hat UK
Message-Id: <1085214261.2781.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 22 May 2004 10:24:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GX4eE1tot+VHsSoaQcIg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> - Does the kernel tell you if your disk doesn't supoprt barriers?  ie:
>   how does the user know if it's working or not?

... and how do you know your disk isn't lying and ignoring the barriers?

"Storage is a Lie" -- Andre


--=-GX4eE1tot+VHsSoaQcIg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBArw41xULwo51rQBIRAsDGAKCqAYD/Wf3LNy1DGNbh2iM8ucXkcgCfZFAn
XM4IGtojoqeHIxOeyqHg4oU=
=5VY9
-----END PGP SIGNATURE-----

--=-GX4eE1tot+VHsSoaQcIg--

