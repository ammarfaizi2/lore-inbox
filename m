Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUH0KCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUH0KCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUH0KCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:02:19 -0400
Received: from hostmaster.org ([212.186.110.32]:49045 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S262279AbUH0KCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:02:16 -0400
Subject: Re: netfilter IPv6 support
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.netfilter.org
In-Reply-To: <20040826220501.GA564@alpha.home.local>
References: <1093546367.3497.23.camel@hostmaster.org>
	 <20040826130024.6ff83dff.davem@redhat.com>
	 <1093555510.3497.33.camel@hostmaster.org>
	 <20040826220501.GA564@alpha.home.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5lkvGZmgxLaDLE3hprNM"
Date: Fri, 27 Aug 2004 12:02:14 +0200
Message-Id: <1093600934.3497.50.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5lkvGZmgxLaDLE3hprNM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fre, 2004-08-27 at 00:05 +0200, Willy Tarreau wrote:
> These features are available in patch-o-matic-ng. They're not in mainline
> because the netfilter team only pushes well tested and non-intrusive chan=
ges.
> But there are lots of people using features from patch-o-matic in product=
ion.

It seems that the netfilter developers are far to conservative in this
case.
- Linux 2.6 is itself is still not deemed completely stable.
- IPv6 support is still marked experimental.
So I doubt someone would blame them for pushing a not so well tested
patch in this case but the current netfilter implementation for IPv6 is
far from useful completeness.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

History has shown that the people who make history do not learn from it.



--=-5lkvGZmgxLaDLE3hprNM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQEVAwUAQS8GpmD1OYqW/8uJAQIdjQf+NIsXxVF0+qASDBeHAZ8FtY9YL3uqJ202
CTM/4vl8oaSvYVEeaSu0j/jfoBhlqDxh6iHDh6kk3NIRzDo1NgZ/KLbcTttiKRiY
l2hJ1Yq0OgQsw4Q1uaWBHqNKKmQ4Ga1VUKNICWCmk9KoeGouY73Q9NBpwLyxP3XT
SSGT//mRaijSweyQ8jJdzj0LuN4HHO4w/cZTpye0cjkSs9pNmYoMq4nHBlrGtbz+
qBi/8q9sI813YpYXYhMUUSY2pMlTeqWXZGFzddLZk9kO24xDam0bNK/ZHhbGNCZr
lsnArwXUtpPOKxXDdNVefMa5PABdllCELYmz96Z03xjpYbvnYb7Kzw==
=h8dI
-----END PGP SIGNATURE-----

--=-5lkvGZmgxLaDLE3hprNM--

