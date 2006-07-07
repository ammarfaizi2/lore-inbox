Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWGGXdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWGGXdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWGGXdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:33:16 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43729 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932391AbWGGXdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:33:15 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
Date: Sat, 8 Jul 2006 09:33:00 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Olivier Galibert <galibert@pobox.com>,
       grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz>
In-Reply-To: <20060707232523.GC1746@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2124904.DLCZC8f5pq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607080933.12372.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2124904.DLCZC8f5pq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 08 July 2006 09:25, Pavel Machek wrote:
> > > So what Pavel wants can be
> > > translated as 'please use already merged code, it can already do what
> > > you want without further changing kernel'.
> >
> > Like we'd want to use unreviewed, extremely new and risky code for
> > something that happily destroy filesystems.
>
> You can either use suspend2 (14000 lines of unreviewed kernel code,
> old) or uswsusp (~500 lines of reviewed kernel code, ~2000 lines of
> unreviewed userspace code, new).

I was going to keep quiet, but I have to say this: If Suspend2 can rightly =
be=20
called unreviewed code, it's only because you've been too busy flaming etc =
to=20
give it serious review. Personally, though, I don't think it's right to cal=
l=20
it unreviewed. I've had and applied feedback from lots of people over time=
=20
(hch, Rafael, Pekka(sp?), Nick, Con and Hugh to name just a few). If they=20
weren't reviewing the code, what were they doing?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2124904.DLCZC8f5pq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEru84N0y+n1M3mo0RAuHyAKD0vNk6+td8kXBRrv5RpJnVtyatJwCfUREz
hIoc4vBRA0cVjdeQ4B9Lz38=
=szMZ
-----END PGP SIGNATURE-----

--nextPart2124904.DLCZC8f5pq--
