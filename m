Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSDVHds>; Mon, 22 Apr 2002 03:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314081AbSDVHdr>; Mon, 22 Apr 2002 03:33:47 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:58597 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S314079AbSDVHdr>;
	Mon, 22 Apr 2002 03:33:47 -0400
Date: Mon, 22 Apr 2002 17:33:44 +1000
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>
Subject: Re: [OFF TOPIC] BK license change
Message-ID: <20020422073344.GA7376@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>
In-Reply-To: <20020421095715.A10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2002 at 09:57:15AM -0700, Larry McVoy wrote:
> Well, now seems like a great time to discuss this.  Ha.
>=20
> It's come to our attention that commercial companies are abusing BK under
> the openlogging rules.  To avoid paying for the product, they either put
> in no comments or obscure comments.  That is a violation of the license,
> but good luck proving that they are doing it on purpose.
>=20
> The real issue is that we know from past history that companies make=20
> changes to GPLed software and then delay access to those changes as
> long as they can (the GPL allows for a "reasonable" amount of lag,
> whatever that is).
>=20
> The intent of the openlogging requirement was to allow people to work
> out in the open on free software, at no charge.  The intent was never=20
> to allow people to work on free software without giving their changes=20
> back.  I'm not commenting on people's rights to hide their changes,=20
> they can do whatever they want, but I *am* saying that we don't have
> support closed use for free.
>=20
> I'm considering a change to the BKL which says that N days after a
> changeset is made, that changeset (and its ancestory) must be available
> on a public bk server.  In other words, put a hard limit on how long
> you may hide.
>=20
> The time period has to be long enough to cover security fixes, DaveM=20
> raised that issue.  I'm thinking 90 days.
>=20
> Note: public server is not limited to bkbits.net.  Any public server is
> fine, so long as it is stable, well known, and available ~95% of the time.
>=20
Does 'public server' imply that the server is running bkd for
anonymous access? I have several small projects under bk that I keep
in repositories that are accesible to people with an account on my
server, but not to anyone else - would this be a license violation?
(I have no problem with openlogging - it just encourages me to make
/intelligent/ checkin comments, or some approximation thereof)

I'd prefer not to have to run bkd on my server if I don't /have/ to.
Minimising the number of services available to be cracked, and all
that . . .=20

Simon Fowler

--=20
PGP public key Id 0x144A991C, or ftp://bg77.anu.edu.au/pub/himi/himi.asc
(crappy) Homepage: http://bg77.anu.edu.au
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://bg77.anu.edu.au/pub/mirrors/css/=20

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8w7zXQPlfmRRKmRwRAr8eAJ0X0D3kLBGQ+FxjUEqnwmnpWz5z+gCgxx25
m/NkHiiuTQHdX9f8YSadppg=
=1Axt
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
