Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbSJGVdT>; Mon, 7 Oct 2002 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263436AbSJGVdT>; Mon, 7 Oct 2002 17:33:19 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:1166 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263434AbSJGVcs>; Mon, 7 Oct 2002 17:32:48 -0400
Date: Mon, 7 Oct 2002 23:38:15 +0200
From: Martin Waitz <tali@admingilde.org>
To: Wichert Akkerman <wichert@wiggy.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 orinoco_cs.c compile failure
Message-ID: <20021007213815.GA1495@admingilde.org>
References: <20021007210817.GD14953@wiggy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20021007210817.GD14953@wiggy.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Oct 07, 2002 at 11:08:17PM +0200, Wichert Akkerman wrote:
> -#include <linux/tqueue.h>
> +#include <linux/workqueue.h>

adding workqueue isn't even needed, just remove tqueue.h

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9of7Hj/Eaxd/oD7IRAjOVAJ90KTwAQ8cLx4dd/PBB3VqPkHszUwCdGYWK
DPZrroFvUh1wbIv8/2yE1ZM=
=Mb/w
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
