Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSJXJy5>; Thu, 24 Oct 2002 05:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265374AbSJXJy5>; Thu, 24 Oct 2002 05:54:57 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:19127 "HELO relay.dstl.gov.uk")
	by vger.kernel.org with SMTP id <S265373AbSJXJyz>;
	Thu, 24 Oct 2002 05:54:55 -0400
Subject: Re: One for the Security Guru's
From: Tony Gale <gale@syntax.dstl.gov.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <ap8f36$8ge$1@dstl.gov.uk>
References: <Pine.LNX.3.95.1021023105535.13301A-100000@dstl.gov.uk>
	<Pine.LNX.4.44.0210231346500.26808-100000@innerfire.net> 
	<ap8f36$8ge$1@forge.intermeta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-sm/k8ySWntfSdaeozWto"
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 24 Oct 2002 11:01:04 +0100
Message-Id: <1035453664.1035.11.camel@syntax.dstl.gov.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sm/k8ySWntfSdaeozWto
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-10-24 at 10:38, Henning P. Schmiedehausen wrote:
> Gerhard Mack <gmack@innerfire.net> writes:
>=20
> >Actually at the place that just went bankrupt on me I had a Security
> >consultant complain that 2 of my servers were outside the firewall.  He
> >recommended that I get a firewall just for those 2 servers but backed of=
f
> >when I pointed out that I would need to open all of the same ports that
> >are open on the server anyways so the vulnerability isn't any less with
> >the firewall.
>=20
> So you should've bought a more expensive firewall that offers protocol
> based forwarding instead of being a simple packet filter.
>=20
> packet filter !=3D firewall. That's the main lie behind most of the
> "Linux based" firewalls.
>=20
> Get the real thing. Checkpoint. PIX. But that's a little
> more expensive than "xxx firewall based on Linux".
>=20

Thats not entirely accurate, or fair. A packet filter is a type of
Firewall (or can be). A Firewall is a means to implement a security
policy, usually specifically a network access policy. A Packet Filter,
including a ""Linux based" firewall" is a perfectly acceptable means of
achieving that goal, if it meets the policy requirements.

Ref. http://csrc.nist.gov/publications/nistpubs/800-10/ (over 7 years
old, but still highly relevant).

Most commercial firewalls are very bad at protecting servers offering
Internet services, they aren't designed to do it.

-tony


--=-sm/k8ySWntfSdaeozWto
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQCVAwUAPbfE4B/0GZs/Z0FlAQIwsQP/cgsyryYs31o6/jxA+/mbpYutZ9Ya8ijA
RxWN7qlBuICaRGqhnuw8QNEfXHAjNiQ7RwgguhrcsSQsu5ZOKAB6v1g23BdCOr04
Z/hQXNoo/vyiQ0jPeAxQ/9K+7dUPBhL6bWWOkGtc5TMoODHS2dJXn0rHFBMh9sFD
3jtHg9FTih4=
=LsCB
-----END PGP SIGNATURE-----

--=-sm/k8ySWntfSdaeozWto--

