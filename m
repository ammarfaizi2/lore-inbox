Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWGHLVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWGHLVL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWGHLVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:21:10 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20696 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S964783AbWGHLVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:21:09 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sat, 8 Jul 2006 21:21:01 +1000
User-Agent: KMail/1.9.1
Cc: Avuton Olrich <avuton@gmail.com>, Bojan Smojver <bojan@rexursive.com>,
       suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       jan@rychter.com, linux-kernel@vger.kernel.org
References: <20060707232523.GC1746@elf.ucw.cz> <3aa654a40607072133i55ffe0d1ke9f0905c6599864c@mail.gmail.com> <20060708111226.GI1700@elf.ucw.cz>
In-Reply-To: <20060708111226.GI1700@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4274770.53iV5TL0Z4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607082121.06045.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4274770.53iV5TL0Z4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 08 July 2006 21:12, Pavel Machek wrote:
> Hi!
>
> > >Now... switching to uswsusp kernel parts will make it slightly harder
> > >to install in the short term (messing with initrd). OTOH there's at
> > >least _chance_ to get to the point where suspend "just works" in
> > >Linux, in the long term...
> >
> > Long term being the key words. When will uswsusp be concidered 'rock
> > solid'? 2008+? Suspend2 is rock solid _today_. Imagine a world where
>
> uswsusp is probably going to be used for SUSE10.2, so it will have to
> be solid at that point. And SUSE10.2 is going to be
> end-of-2006/early-2007, IIRC.
>
> > Linux drivers were as reliable as swsusp (granted I tried to get
> > uswsusp working and I gave up before messing with the initrd stuff).
>
> Can I get proper bug report?
>
> > In order for uswsusp to make Suspend2 obsolete, it would have to *at
> > least* support what Suspend2 does. Unfortunately, that isn't the case
> > right now.
>
> Suspend2 does not have all the features uswsusp has, and uswsusp does
> not have all the features suspend2 has.

Oh. You mean the rsa key thing?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart4274770.53iV5TL0Z4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEr5UiN0y+n1M3mo0RApuZAJ9yLfg4lEp1unu+YO+zz4JXhTxjFwCgg09v
8kkRLY6jw25kL5MU0cjTsxY=
=ezvc
-----END PGP SIGNATURE-----

--nextPart4274770.53iV5TL0Z4--
