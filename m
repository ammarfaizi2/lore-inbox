Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUHWIuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUHWIuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 04:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUHWIuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 04:50:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18320 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267551AbUHWIuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 04:50:06 -0400
Date: Mon, 23 Aug 2004 10:50:00 +0200
From: Frank =?iso-8859-1?Q?Matthie=DF?= <frankm@lug-owl.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Trivial IPv6-for-Fedora HOWTO
Message-ID: <20040823085000.GA12383@dvmwest.dvmwest.de>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <4129236E.9020205@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <4129236E.9020205@pobox.com>
X-PGP-Key: http://lug-owl.de/~frankm/pubkey_CF1B698D.asc
X-PGP-Fingerprint: 2473 4985 E3B2 990D CB32  AA11 96FC 72B9 CF1B 698D
X-message-Flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff Garzik [2004-08-23 00:51 CEST]:
>=20
> So, thanks to David Woodhouse for showing me how to do this.  IPv6=20
> appears to be very, very close to a Just Works(tm) state.
>=20
> These instructions are for Fedora Core 2 users, and describe how to set=
=20
> up IPv6 automatically tunnelling (6to4) on an IPv4 network.  If you are=
=20
> stuck on an IPv4-only network (like most of us), this enables=20
> communication with IPv6 hosts quickly, easily, and transparently.
>=20
> (this HOWTO is archived at http://yyz.us/ipv6-fc2-howto.html)
[...]
>=20
> If you have an iptables ipv4 firewall, you'll want to
>=20
[...]
>=20
> F2) duplicate your ipv4 firewall rules for ipv6, using ip6tables.  Some=
=20
> things, like masquerade, are not applicable to ipv6.

Does Fedora Core 2 has patches, which add ipv6 statefull inspection to
netfilter? If not, this is only true for rules without statefull
inspection.

Frank.
--=20
Frank Matthie=DF

"Was kommt denn als n=E4chstes? Ein Studiengang 6 Semester sendmail mit
 Aufbaustudium `sendmail security'?" -- Frank Guthausen

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKa+3LXa7dZqO5SERAm0+AJ4r5i/1EaxghTsL6Tg0mVSKuhSUCACfVMN5
acEthcDvhBwS31zz04zFVHs=
=91nx
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
