Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTLVTfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTLVTfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:35:24 -0500
Received: from hostmaster.org ([80.110.173.103]:12672 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264506AbTLVTfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:35:16 -0500
Subject: Re: 2.6.0 lockup with de4x5/de2104x driver
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1072119837.1383.11.camel@hostmaster.org>
References: <1072119837.1383.11.camel@hostmaster.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fKIaeDfLGypioJNaB2H+"
Message-Id: <1072121704.1435.3.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 20:35:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fKIaeDfLGypioJNaB2H+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Some more testing revealed that the de4x5 driver of the 2.6.0 kernel
seems to be working with SMP disabled. Unfortunately this required a new
kernel build instead of simply passing the nosmp parameter.

Regards
Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

History has shown that the people who make history do not learn from it.

--=-fKIaeDfLGypioJNaB2H+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAP+dHY2D1OYqW/8uJAQJEkQf/RC6F00semjFDCuTb7YHD1zpwihlvWJGi
X35NtdGR26rmARq+WF31sD34uwYG3DQeWZlc1dZHUihGqv1vOBlAYudk9D2r6ie6
juxPnMMVtDJqCoBx+aQ7KcrfGogDKBPN6hm2VLtu3nIktW4xXB7kqjqZWvzM9Fna
+xR1UAbJBS82N8bsZwAXxF6IqszaU0qE/lXEF1mjeqqu68TinzQAuflA2PLJ8BQd
cISaX8a46SY8iChfsjQhOrVJjlOvCRCH+kNG3t1j3VJl9/Uky02Z9XnpURwdO15y
a9LkFyjpvY8JWmhHrMD9eokcOiFVyj2ODqwNx/SwnCgjOliBHy5Wkg==
=dsiL
-----END PGP SIGNATURE-----

--=-fKIaeDfLGypioJNaB2H+--

