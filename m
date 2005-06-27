Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVF0JV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVF0JV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVF0JV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:21:57 -0400
Received: from nysv.org ([213.157.66.145]:55990 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261973AbVF0JVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:21:50 -0400
Date: Mon, 27 Jun 2005 12:21:38 +0300
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050627092138.GD11013@nysv.org>
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6zkAHxOZJkiczrA"
Content-Disposition: inline
In-Reply-To: <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--j6zkAHxOZJkiczrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2005 at 11:34:50PM -0400, Horst von Brand wrote:
>David Masover <ninja@slaphack.com> wrote:

>> I think Hans (or someone) decided that when hardware stops working, it's
>> not the job of the FS to compensate, it's the job of lower layers, or
>> better, the job of the admin to replace the disk and restore from
>> backups.
>Handling other people's data this way is just reckless irresponsibility.
>Sure, you can get high performance if you just forego some of your basic
>responsibilities.

Your honest-to-bog opinion is that the FS vendor is responsible for
the admin not taking backups or the hardware vendor shipping crap?

*still trying to understand how that can be*

--=20
mjt


--j6zkAHxOZJkiczrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCv8UiIqNMpVm8OhwRAnOTAJ45eYnRA5qu76wDikLbuoMMLgub+ACdH21T
qmysNUGGUTyynfCoqnn6c/Y=
=B/KR
-----END PGP SIGNATURE-----

--j6zkAHxOZJkiczrA--
