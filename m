Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVAMTrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVAMTrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVAMTnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:43:50 -0500
Received: from grendel.firewall.com ([66.28.58.176]:37281 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261442AbVAMTmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:42:50 -0500
Date: Thu, 13 Jan 2005 20:42:46 +0100
From: Marek Habersack <grendel@caudium.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113194246.GC24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <1105627541.4624.24.camel@localhost.localdomain>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox scribbled:
> On Mer, 2005-01-12 at 17:42, Marcelo Tosatti wrote:
> > The kernel security list must be higher in hierarchy than vendorsec.
> >=20
> > Any information sent to vendorsec must be sent immediately for the kern=
el
> > security list and discussed there.
>=20
> We cannot do this without the reporters permission. Often we get
I think I don't understand that. A reporter doesn't "own" the bug - not the
copyright, not the code, so how come they can own the fix/report?

> material that even the list isn't allowed to directly see only by
> contacting the relevant bodies directly as well. The list then just
> serves as a "foo should have told you about issue X" notification.
This sounds crazy. I understand that this may happen with proprietary
software, or software that is made/supported by a company but otherwise ope=
nsource
(like OpenOffice, for instance), but the kernel?

regards,

marek

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5s82q3909GIf5uoRAhZqAJ4qKDTqnrjMsLxCpo0LVGK+mgHA7gCfQ7R6
olA25AAvqR22A1lRDDkjNqk=
=NjTz
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
