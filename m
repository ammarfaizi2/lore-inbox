Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWEFVFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWEFVFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 17:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWEFVFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 17:05:25 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46258 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S932072AbWEFVFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 17:05:25 -0400
From: Michael Helmling <supermihi@web.de>
To: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: New, yet unsupported USB-Ethernet adaptor
Date: Sat, 6 May 2006 23:05:20 +0200
User-Agent: KMail/1.9.1
Cc: "Ioan Ionita" <opslynx@gmail.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <200605022303.10832.supermihi@web.de> <d9def9db0605050554m7b1e093di85782c1b09ca2636@mail.gmail.com>
In-Reply-To: <d9def9db0605050554m7b1e093di85782c1b09ca2636@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1426170.3YvNsdGz8u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605062305.20750.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1426170.3YvNsdGz8u
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Markus,

I'm sorry but your attachment has 0kb size. :(

On Friday 05 May 2006 14:54, Markus Rechberger wrote:
> Hi Michael,
>=20
> I mailed you the complete package it compiled fine but I'm also unable to
> test since I don't have such a device either
> I should have known about this thread earlier :)
>=20
> Markus
>=20
> On 5/2/06, Michael Helmling <supermihi@web.de> wrote:
> >
> >
> >
> > Am Dienstag 02 Mai 2006 22:40 schrieb Ioan Ionita:
> > > On 5/2/06, Michael Helmling <supermihi@web.de> wrote:
> > > > Thank you very much for the immediate answer.
> > > > I applied the patch  - well, I had to do this manually, for some
> > reason, I
> > > > assume bad formatting in my mail program, patch -p0 < patch1 didn't
> > work.
> > Or
> > > > am I using the wrong command?
> > >
> > > You shoud use patch -p1< patch
> >
> > $ patch -p1 < patch
> > patching file mcs7830.c
> > Hunk #1 FAILED at 1309.
> > Hunk #2 FAILED at 1370.
> > Hunk #3 FAILED at 1503.
> > Hunk #4 FAILED at 1935.
> > Hunk #5 FAILED at 1997.
> > Hunk #6 FAILED at 2044.
> > Hunk #7 FAILED at 2404.
> > 7 out of 7 hunks FAILED -- saving rejects to file mcs7830.c.rej
> >
> > Don't know why. :( But since it are only a few lines this isn't a major
> > problem.
> >
> > > Me neither. It was a quick & dirty patch, I must have missed
> > > something. I'll toy around with it some more.
> >
> > Good luck!
> > >
> > >
> > > P.S In the future, make sure you use reply-to-all. Thanks
> >
> > Ok.
> >
> >
> >
>=20
>=20
> --
> Markus Rechberger
>=20

--nextPart1426170.3YvNsdGz8u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEXQ+QcLJiNWFgTBIRAs8aAKCGIxVTsW1L5fN+Stt6wQiuzWSWOgCfSraH
BOLG12YHkGpdeA7HF260/98=
=/tnw
-----END PGP SIGNATURE-----

--nextPart1426170.3YvNsdGz8u--
