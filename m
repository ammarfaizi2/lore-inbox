Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbTCLTqr>; Wed, 12 Mar 2003 14:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261884AbTCLTqr>; Wed, 12 Mar 2003 14:46:47 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:28587 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261737AbTCLTqq>; Wed, 12 Mar 2003 14:46:46 -0500
Date: Wed, 12 Mar 2003 20:57:14 +0100
From: Martin Waitz <tali@admingilde.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030312195714.GB1340@admingilde.org>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <XFMail.20030311171056.pochini@shiny.it> <20030312180819.GB27366@admingilde.org> <Pine.LNX.4.50.0303121027560.991-100000@blue1.dev.mcafeelabs.com> <20030312192122.GA1340@admingilde.org> <Pine.LNX.4.50.0303121133280.991-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303121133280.991-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Wed, Mar 12, 2003 at 11:39:31AM -0800, Davide Libenzi wrote:
> It's not the API that ppl does not understand, the API is the same. It's
> the Edge Triggered event distribution architecture.
which is part of the API ;)

> The equation :
>=20
> "not understood architecture" =3D=3D "flawed architecture"
>=20
> is false in all my books.

that is right.
however, the probability of being flawed is much higher for things
that are not being understood...

but anyway, as you say APIs are subjective and that's perfectly fine.
if anyone wants to have a different api, he can create it on his own.

> > but that's not the point here, i just wanted to point out that there are
> > situations that are easier to solve with one or the other semantics.
> > and there /is/ a need for level-based events.
>=20
> That's a completely different thing. The new epoll gives you both
> behaviours on a per-fd basis.
which is a good thing

thanks for the great work!

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.            Benjamin Franklin (1706 - 1790)

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+b5EZj/Eaxd/oD7IRAl4rAJ0X/1366I8CGC9arman1tBX9a8bpgCfTM+B
hzh2I2CRVLlRVU5rdR4Wc24=
=flDC
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
