Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWGLKQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWGLKQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGLKQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:16:33 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:56554 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751194AbWGLKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:16:32 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Wed, 12 Jul 2006 20:16:20 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607120900.49828.ncunningham@linuxmail.org> <200607121209.05766.rjw@sisk.pl>
In-Reply-To: <200607121209.05766.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2157687.mooE20Fd64";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607122016.28280.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2157687.mooE20Fd64
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 12 July 2006 20:09, Rafael J. Wysocki wrote:
> We're doing something like you are, but I think we're using some other
> option in LZF, because the resulting image size is 30-40% of the
> uncompressed one. That's better for encryption later on, but obviously not
> for speed.

Maybe it's just that the caches compress better? 50% is common, but lower=20
values are sometimes seen.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2157687.mooE20Fd64
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEtMv8N0y+n1M3mo0RAg7oAKCvoOQoe8DPA4/HyTdvNjMZMzDkKwCeLjRW
FefGyYt6Gg7wYC4U/6j+3SI=
=kjTw
-----END PGP SIGNATURE-----

--nextPart2157687.mooE20Fd64--
