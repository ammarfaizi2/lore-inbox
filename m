Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVAMUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVAMUiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVAMUgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:36:18 -0500
Received: from grendel.firewall.com ([66.28.58.176]:43425 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261383AbVAMUcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:32:08 -0500
Date: Thu, 13 Jan 2005 21:32:06 +0100
From: Marek Habersack <grendel@caudium.net>
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113203206.GE24970@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113200308.GC3555@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <20050113200308.GC3555@redhat.com>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2005 at 03:03:08PM -0500, Dave Jones scribbled:
> On Thu, Jan 13, 2005 at 08:42:46PM +0100, Marek Habersack wrote:
>  > On Thu, Jan 13, 2005 at 03:36:27PM +0000, Alan Cox scribbled:
>  > > On Mer, 2005-01-12 at 17:42, Marcelo Tosatti wrote:
>  > > > The kernel security list must be higher in hierarchy than vendorse=
c.
>  > > >=20
>  > > > Any information sent to vendorsec must be sent immediately for the=
 kernel
>  > > > security list and discussed there.
>  > >=20
>  > > We cannot do this without the reporters permission. Often we get
>  > I think I don't understand that. A reporter doesn't "own" the bug - no=
t the
>  > copyright, not the code, so how come they can own the fix/report?
>=20
> Security researchers are an odd bunch. They're very attached to their
> bugs in the sense they want to be the ones who get the glory for
> having reported it.
Let them have it! We can even chip in to run banner adds on freshmeat with
their name on it, I'm all game for that. Or create an RFC-like archive of
the vulnerabilities, ruled by the same rules - no changes after publishing.
Their names will be circulating around the internet forever.
=20
> As soon as bugs start getting forwarded around between lists, the
> potential for leaks increases greatly. The recent fiasco surrounding
> one of the isec.pl holes was believed to have been caused due to
> someone 'sniffing upstream' for example.
I think it would be a non-issue if there was no drive towards keeping it
secret at all cost. It would be out in the open, nothing else, nothing more.

> When issues get leaked, the incentive for a researcher to use the
> same process again goes away, which hurts us.  Basically, trying
> to keep them happy is in our best interests.
You've said they want glory, we can give it to them in many ways without
keeping their discoveries secret.=20

best regards,

marek

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5trGq3909GIf5uoRAuymAJ439VQdFF8QQdKBXJCfYV4f3LuKmwCeKUnt
m6gWDZmIzIdtEoBLcv3yiBk=
=X94S
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
