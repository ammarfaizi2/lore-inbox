Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVANNzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVANNzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 08:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVANNzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 08:55:38 -0500
Received: from grendel.firewall.com ([66.28.58.176]:6819 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261984AbVANNz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 08:55:29 -0500
Date: Fri, 14 Jan 2005 14:55:28 +0100
From: Marek Habersack <grendel@caudium.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050114135528.GA2239@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <1105643984.5193.95.camel@localhost.localdomain> <20050113204415.GF24970@beowulf.thanes.org> <20050114102249.GA3539@wiggy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20050114102249.GA3539@wiggy.net>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2005 at 11:22:49AM +0100, Wichert Akkerman scribbled:
> Previously Marek Habersack wrote:
> > So it sounds that we, the men-in-the-crowd are really left out in the c=
rowd,
> > people who are affected the most by the issues. Since the vendors are n=
ot
> > affected by the bugs (playing a devil's advocate here), since they fix =
them
> > for their machines as they appear, way before they get public.
>=20
> vendor suffer from that as well. Suppose vendors learn of a problem in
> a product they visibly use such as apache or rsync. If all vendors
> suddenly update their versions or disable things that will be noticed as
> well, so vendors can't do that.
So yet another reason why such closed list does more harm than good - it
hurts security, if what you said above does happen.

regards,

marek

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB589Qq3909GIf5uoRAsy9AJ4rhoPPseRAotCdz9NwYG75G8wwYwCfbXuI
d6ZrBmlDW3wyPjD7WYYEB+c=
=SwpC
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
