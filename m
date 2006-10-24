Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWJXL1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWJXL1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWJXL1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 07:27:20 -0400
Received: from mail.phnxsoft.com ([195.227.45.4]:36356 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1030317AbWJXL1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 07:27:19 -0400
Message-ID: <453DF87F.8010009@imap.cc>
Date: Tue, 24 Oct 2006 13:26:55 +0200
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
       akpm@osdl.org
Subject: Re: [PATCH -mm] isdn/gigaset: use bitrev8
References: <20061024085657.GD7703@localhost>
In-Reply-To: <20061024085657.GD7703@localhost>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA7B5A7B1667D87ABE3FC6059"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7B5A7B1667D87ABE3FC6059
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Oct 2006 17:56:57 +0900, Akinobu Mita wrote:
> Use bitrev8 for gigaset isdn driver.

Great. Thanks.

> Cc: Karsten Keil <kkeil@suse.de>
> Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
> Cc: Hansjoerg Lipp <hjlipp@web.de>
> Cc: Tilman Schmidt <tilman@imap.cc>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Tilman Schmidt <tilman@imap.cc>
Acked-by: Hansjoerg Lipp <hjlipp@web.de>

>  drivers/isdn/gigaset/Kconfig     |    1 +
>  drivers/isdn/gigaset/asyncdata.c |    5 +++--
>  drivers/isdn/gigaset/common.c    |   37 ------------------------------=
-------
>  drivers/isdn/gigaset/gigaset.h   |    4 ----
>  drivers/isdn/gigaset/isocdata.c  |    5 +++--
>  5 files changed, 7 insertions(+), 45 deletions(-)

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigA7B5A7B1667D87ABE3FC6059
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFFPfh/MdB4Whm86/kRAllvAJ9K8pL1jZQw1wWGa0QPJvvh2gZlxACVHF8K
mM4Y6kdeo+qazp5iQRKvDg==
=82XI
-----END PGP SIGNATURE-----

--------------enigA7B5A7B1667D87ABE3FC6059--
