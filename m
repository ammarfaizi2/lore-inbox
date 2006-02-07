Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWBGAq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWBGAq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWBGAq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:46:56 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:33423 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964904AbWBGAqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:46:54 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 10:43:30 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602070957.39712.nigel@suspend2.net> <20060207002910.GA1575@elf.ucw.cz>
In-Reply-To: <20060207002910.GA1575@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1402294.jJG7BOu5iM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071043.34715.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1402294.jJG7BOu5iM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 10:29, Pavel Machek wrote:
> Hi!
>
> > > This point is valid, but I don't think the users will _have_ _to_
> > > switch to the userland suspend.  AFAICT we are going to keep the
> > > kernel-based code as long as necessary.
> > >
> > > We are just going to implement features in the user space that need
> > > not be implemented in the kernel.  Of course they can be implemented
> > > in the kernel, and you have shown that clearly, but since they need
> > > not be there, we should at least try to implement them in the user
> > > space and see how this works.
> > >
> > > Frankly, I have no strong opinion on whether they _should_ be
> > > implemented in the user space or in the kernel, but I think we won't
> > > know that until we actually _try_.
> > >
> > > That said, I like the idea and I'm going to work on it.  I'll also
> > > appreciate any help very much.
> >
> > Wow. I wish Pavel wrote replies like that. We'd get on a whole lot
> > better.
> >
> > Pavel, am I doing something wrong that I'm not clicking to, which is
> > stirring you up? I really don't want to. I want to work with you guys
> > instead of against you, but it seems to me like every attempt at
> > interaction with you degenerates into something far less than ideal.
>
> Nothing I could name... I guess I'll just let you cooperate with
> Rafael, he can translate ;-).

:>

> [Well, perhaps there's one thing. Have you seen Al Viro's mails? He
> tends to use quite a strong language. I guess asking you to talk like
> him is too much to ask (but it would probably help ;-), but notice

Heh. Maybe I should look at some, after reading that!

Maybe I can also encourage you to try not to sound so confontational?=20
Perhaps we can meet half way.

> that my and his native languages have quite a lot in common. Perhaps
> I'm doing poor job translating into English at higher level...]

Well, if we know it's just a communication and not a clash of=20
personalities, that alone should help.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1402294.jJG7BOu5iM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5+02N0y+n1M3mo0RAsv6AKCR0wOllZK8KJemQri21/sbtEVrqgCfX76y
slyxzoAo1w/0428uisWXEkU=
=dTgG
-----END PGP SIGNATURE-----

--nextPart1402294.jJG7BOu5iM--
