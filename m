Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVAMVGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVAMVGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVAMVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:04:09 -0500
Received: from grendel.firewall.com ([66.28.58.176]:53409 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261697AbVAMVCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:02:34 -0500
Date: Thu, 13 Jan 2005 22:02:29 +0100
From: Marek Habersack <grendel@caudium.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113210229.GG24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net> <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <1105645267.4644.112.camel@localhost.localdomain>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 07:41:10PM +0000, Alan Cox scribbled:
[snip]
> > suspect that more people run self-compiled kernels on their servers tha=
n the
> > vendor kernels, I might be wrong on that). If there is a list that's at
>=20
> I'd say you are very very wrong from the data I have access too,
> probably of the order of 1000:1 wrong or more.
I stand corrected then, you have access to much better sources than I do, no
doubts.

> > > Licensing is irrelevant.  Like it or not, the person who is discoveri=
ng
> > > the bugs has some say in how you deal with the information.  It's in =
our
> > > best interest to work nicely with these folks, not marginalize them.
>=20
> > It's not about marginalizing, because by requesting that their report is
> > kept secret for a while and known only to a small bunch of people, you =
could
> > say they are marginalizing us, the majority of people who use the linux
> > kernel (us - those who aren't on the vendor-sec list). It's, again IMHO,
>=20
> They chose to. A lot of people report bugs directly to Linus too or to
> the lists or to full-disclosure depending upon their view. The folks who
> report bugs in private either to Linus or to vendor-sec or maintainers
> or whoever generally believe that the bad guys can move faster and cause
They can still move faster when the vulnerability (and the fixed vendor
kernels) are released. The people who are to install the kernels usually
cannot act immediately, so if the bad guys have somebody on target, they
will root them anyway. I see no difference here to a model of totally open
disclosure list.

> a lot of damage if a bug isn't fixed before announce.
Again, it works for vendors, not for end users, IMO.

> Thats based on the observation that
> 	- the bad guys have to move a small exploit versus a large binary
delayed release doesn't change that. One still needs to download and deploy
the kernels (possibly compiling them if they have to).

> 	- the exploit doesn't have to pass quality assurance, you just write
> more
again, closed mailing lists don't change that

> 	- they can automate the attack tools very effectively=20
ditto

> So the non-disclosure argument is perhaps put as "equality of access at
> the point of discovery means everyone gets rooted.". And if you want a
> lot more detail on this read papers on the models of security economics
> - its a well studied field.
Theory is fine, practice is that the closed disclosure list changes matters
for a vaste minority of people - those who are to install the fixed kernels
are in perfectly the same situation they would be in if there was a fully
open disclosure list.

all of this is IMHO, of course - cannot stress that more :)

best regards,

marek

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5uHlq3909GIf5uoRAl8ZAJ9i891IvD3xCUe1X78yMxlHjON9cwCfdzMZ
3l3xM93yyfySg5LdUJcfdHk=
=QcCU
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--
