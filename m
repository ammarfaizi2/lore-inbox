Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbTIGUks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 16:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbTIGUks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 16:40:48 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:48001
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S261421AbTIGUkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 16:40:46 -0400
Date: Sun, 7 Sep 2003 22:40:46 +0200
To: John Bradford <john@grabjohn.com>, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030907204046.GA2135@leto2.endorphin.org>
References: <200309051225.h85CPOYr000323@81-2-122-30.bradfords.org.uk> <20030905122501.GA3250@leto2.endorphin.org> <20030906220800.GA18850@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20030906220800.GA18850@DUK2.13thfloor.at>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063831246.78c1@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 07, 2003 at 12:08:00AM +0200, Herbert Poetzl wrote:

>=20
> what it the problem with gas anyway? why not convert
> the masterpiece to GNU Assembler? there even exists=20
> some script to aid in masm to gas conversion ...
>=20
> http://www.delorie.com/djgpp/faq/converting/asm2s-sed.html

Thanks. Already found, tried, does not work.
It doesn't even convert register names properly. I know enough of sed to fix
broken scripts resulting from incorrect line wrapping, but I'm certainly not
going to work on this.=20

I started to work on converting it to gas, but I stopped after the first
hour. It's just too much work to be fun. I won't convert it.

Regards, Clemens

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/W5fFW7sr9DEJLk4RAo9RAJ9dVqDQiEHnH7sN1QnDGHY/5KpVJACfeSPn
lYZjATcrns1lmVrpvfIMFdc=
=Whhr
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
