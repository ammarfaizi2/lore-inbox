Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWGIADl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWGIADl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWGIADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:03:41 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:32653 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1030422AbWGIADk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:03:40 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sun, 9 Jul 2006 10:03:35 +1000
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Olivier Galibert <galibert@pobox.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <1152380363.27368.12.camel@localhost.localdomain> <20060708235721.GH2546@elf.ucw.cz>
In-Reply-To: <20060708235721.GH2546@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9606536.ODs8vCDA5T";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607091003.39606.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9606536.ODs8vCDA5T
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 09:57, Pavel Machek wrote:
> Hi!
>
> > > > Very often, choice is good. but for something this fundamental, it =
is
> > > > not. We also don't have 2 scsi layers for example.
> > >
> > > We have 2 ide layers, 2 usb-storage drivers, 2 sound systems and we
> >
> > (We've had effectively two SCSI layers before now btw when we've done
> > transitions from old_eh to new_eh)
> >
> > > have had 2 pcmcia subsystems and 2 usb subsystems.  At one point, it's
> > > the only way to find out what will work out.  Suspend2 and uswsusp
> > > have very different fundamental designs, and it's quite unclear at
> > > that point which one is the right one.
> >
> > I'd like to see this cleared up at OLS/Kernel summit.
>
> Unless something very wrong happens, I'll be at OLS/Kernel summit.
>
> ...it is going to be interesting week. I expect apparmor flamefest,
> and this... Any idea where to buy cheap asbestos underwear? :-)

I won't be there, but I'm happy to answer any questions by email or irc if=
=20
that will help.

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart9606536.ODs8vCDA5T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsEfbN0y+n1M3mo0RAuxwAJ0eCufxDmB7aQMdJuepresr+auFmgCZAfV6
PKQv9jtn7VZHQCF3b8h4f+8=
=i0Kx
-----END PGP SIGNATURE-----

--nextPart9606536.ODs8vCDA5T--
