Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVAZLE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVAZLE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 06:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVAZLE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 06:04:58 -0500
Received: from dea.vocord.ru ([217.67.177.50]:24255 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262275AbVAZLDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 06:03:44 -0500
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Christoph Hellwig <hch@infradead.org>
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050126101434.GA7897@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124175449.GK3515@stusta.de> <20050124213442.GC18933@kroah.com>
	 <20050124214751.GA6396@infradead.org> <20050125060256.GB2061@kroah.com>
	 <20050125195918.460f2b10.khali@linux-fr.org>
	 <20050126003927.189640d4@zanzibar.2ka.mipt.ru>
	 <20050125224051.190b5ff9.khali@linux-fr.org>
	 <20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
	 <20050126101434.GA7897@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Jl/KBRx2ILQbG65EINMS"
Organization: MIPT
Date: Wed, 26 Jan 2005 13:59:17 +0300
Message-Id: <1106737157.5257.139.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 10:53:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Jl/KBRx2ILQbG65EINMS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 10:14 +0000, Christoph Hellwig wrote:
> On Wed, Jan 26, 2005 at 01:35:56AM +0300, Evgeniy Polyakov wrote:
> > I have one rule - if noone answers that it means noone objects,
> > or it is not interesting for anyone, and thus noone objects.
>=20
> That's simply not true.  The amount of patches submitted is extremly
> huge and the reviewers don't have time to look at everythning.
>=20
> If no one replies it simply means no one has looked at it in enough
> detail to comment yet.

That is why I resent it several times.
Then I asked for inclusion.

I never send it to lkml just because simple static/non static + module
name
discussion in lkml already overflowed into more than 20 messages...

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Jl/KBRx2ILQbG65EINMS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB93gFIKTPhE+8wY0RAuYfAJ9NEgxTDiMzNgeazcJMcr63TrlDhQCbBoME
UAGcNMAENEk1Ray2rEQeG6k=
=3+/D
-----END PGP SIGNATURE-----

--=-Jl/KBRx2ILQbG65EINMS--

