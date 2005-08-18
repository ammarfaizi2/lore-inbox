Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVHRVQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVHRVQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVHRVQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:16:14 -0400
Received: from server262.com ([64.14.68.15]:26066 "EHLO server262.com")
	by vger.kernel.org with ESMTP id S932450AbVHRVQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:16:14 -0400
Subject: Re: HDAPS, Need to park the head for real
From: Adam Goode <adam@evdebs.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <20050818204904.GE516@openzaurus.ucw.cz>
References: <1124205914.4855.14.camel@localhost.localdomain>
	 <20050816200708.GE3425@suse.de>  <20050818204904.GE516@openzaurus.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BKqeCwEKzffEa5rzVKxi"
Date: Thu, 18 Aug 2005 17:15:55 -0400
Message-Id: <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BKqeCwEKzffEa5rzVKxi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-18 at 22:49 +0200, Pavel Machek wrote:
> Please make it "echo 1 > frozen", then userspace can do "echo 0 > frozen"
> after five seconds.


What if the code to do "echo 0 > frozen" is swapped out to disk? ;)


Thanks,

Adam


--=-BKqeCwEKzffEa5rzVKxi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDBPqLlenB4PQRJawRAr8RAJ9fxYF5ul/wCJsWasHlY6gF7b4DNACgtl5Y
KlW44ESW5jwr0yxuo32kbfQ=
=TYa8
-----END PGP SIGNATURE-----

--=-BKqeCwEKzffEa5rzVKxi--

