Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVAZQgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVAZQgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVAZQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:36:31 -0500
Received: from dea.vocord.ru ([217.67.177.50]:45231 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262010AbVAZQff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:35:35 -0500
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: Christoph Hellwig <hch@infradead.org>, Jean Delvare <khali@linux-fr.org>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000501260600fb8589e@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124213442.GC18933@kroah.com> <20050124214751.GA6396@infradead.org>
	 <20050125060256.GB2061@kroah.com>
	 <20050125195918.460f2b10.khali@linux-fr.org>
	 <20050126003927.189640d4@zanzibar.2ka.mipt.ru>
	 <20050125224051.190b5ff9.khali@linux-fr.org>
	 <20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
	 <20050126101434.GA7897@infradead.org> <1106737157.5257.139.camel@uganda>
	 <d120d5000501260600fb8589e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MAKTNuJEVa/zeWgpgT7f"
Organization: MIPT
Date: Wed, 26 Jan 2005 19:38:48 +0300
Message-Id: <1106757528.5257.221.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 16:33:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MAKTNuJEVa/zeWgpgT7f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 09:00 -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 13:59:17 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > On Wed, 2005-01-26 at 10:14 +0000, Christoph Hellwig wrote:
> > > On Wed, Jan 26, 2005 at 01:35:56AM +0300, Evgeniy Polyakov wrote:
> > > > I have one rule - if noone answers that it means noone objects,
> > > > or it is not interesting for anyone, and thus noone objects.
> > >
> > > That's simply not true.  The amount of patches submitted is extremly
> > > huge and the reviewers don't have time to look at everythning.
> > >
> > > If no one replies it simply means no one has looked at it in enough
> > > detail to comment yet.
> >=20
> > That is why I resent it several times.
> > Then I asked for inclusion.
> >=20
> > I never send it to lkml just because simple static/non static + module
> > name
> > discussion in lkml already overflowed into more than 20 messages...
>=20
> Well, not everyone is subscribed to lm_sensors mailing list but
> nonetheless are interested when a new subsystem is introduced into the
> kernel. There several established subsystems (network, USB, ide) whose
> maintainers people trust either because of the good track record or
> because it affects small number of people so the main discussion is
> kept on special lists. But even then most patches are presented on
> LKML when issues ironed out on special list.
>=20
> With a new subsystem it is wise to present it to LKML so it gets wider co=
verage.
>=20

Khm-khm, if we will always wait untill everyone will comment the code or
even initial
design, then nothing will be created at all.

Btw, where was comments about w1, kernel connector and acrypto?=20
They were presented several times in lkml and all are completely new
subsystems.
Should I stop developing just because I did not get comments?

Above discussion was not borned because it is new subsystem, btw...


Ok, I want to thank everyone for discussion.
I believe that new subsystem must be discussed in specific mail lists
before
it goes mainstream, but not necessarily in lkml.
But if it really changes a lot of things, then of course it should be
presented=20
in lkml.

Thank you.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-MAKTNuJEVa/zeWgpgT7f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB98eYIKTPhE+8wY0RAiY+AKCCBS7ZL1xSudF6wytANmdgoTnUCwCfdazu
DQjf7HfYpG+ebfODdgBUVu8=
=FgiZ
-----END PGP SIGNATURE-----

--=-MAKTNuJEVa/zeWgpgT7f--

