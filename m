Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbULMTnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbULMTnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbULMTj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:39:58 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:2956 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262279AbULMSo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 13:44:57 -0500
Subject: Re: [openib-general] [PATCH][v3][17/21] Add IPoIB
	(IP-over-InfiniBand) driver
From: Tom Duffy <tduffy@sun.com>
To: Roland Dreier <roland@topspin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, openib-general@openib.org
In-Reply-To: <20041213109.JT1ejUdkRIUXbWOm@topspin.com>
References: <20041213109.JT1ejUdkRIUXbWOm@topspin.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+Gg/yNtd8JYVNcpHnKZq"
Date: Mon, 13 Dec 2004 10:44:24 -0800
Message-Id: <1102963464.9258.11.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+Gg/yNtd8JYVNcpHnKZq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-13 at 10:09 -0800, Roland Dreier wrote:
> --- linux-bk.orig/drivers/infiniband/Kconfig	2004-12-13 09:44:43.93625277=
9 -0800
> +++ linux-bk/drivers/infiniband/Kconfig	2004-12-13 09:44:49.385450009 -08=
00
> @@ -2,7 +2,6 @@
> =20
>  config INFINIBAND
>  	tristate "InfiniBand support"
> -	default n
>  	---help---
>  	  Core support for InfiniBand (IB).  Make sure to also select
>  	  any protocols you wish to use as well as drivers for your

Is there a reason why you put this in in an earlier patch and then take
it out later?

-tduffy

--=-+Gg/yNtd8JYVNcpHnKZq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBveMIdY502zjzwbwRAuywAKCbVtRdF/PW+JhPLjveoWFGzCKrhACgjoqK
64lZj1fH0R7rZbF+pAmN4MI=
=VJFe
-----END PGP SIGNATURE-----

--=-+Gg/yNtd8JYVNcpHnKZq--
