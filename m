Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWBTLrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWBTLrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWBTLqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:46:42 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:24238 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964855AbWBTLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:46:30 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 20:40:57 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Pavel Machek <pavel@suse.cz>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430269.3429.8.camel@mindpipe>
In-Reply-To: <1140430269.3429.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart51847868.StzgUtFZtW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602202041.02085.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart51847868.StzgUtFZtW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 20:11, Lee Revell wrote:
> On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > It is less work to port suspend2's features into userspace than to
> > > make suspend2 acceptable to mainline. Both will mean big changes,
> >
> > and
> >
> > > may cause some short-term problems, but it will be less pain than
> > > maintaining suspend2 forever. Please help with the former...
> >
> > These "big changes" is something I have a problem with, since it means
> > to delay a working suspend/resume in Linux for another
> > "short-term" (so
> > what does it mean: 1 month? six? twelve?).
>
> If you have a big problem with this then ask the developer why he didn't
> submit it 1 or 6 or 12 months sooner, don't complain to the kernel
> developers.

I submitted it for review 15 months ago. Since then I've been working to ap=
ply=20
the suggestions, clean things up more and finish the last few bits of missi=
ng=20
functionality. Contrary to what Sebas implied earlier, I'm not paid to work=
=20
on Suspend2 on a full time basis. I work on it up to 20% of work hours=20
(thanks, Cyclades), and the remainder of the work is done in my own time.=20
This often means that things move more slowly than I'd like, but my wife wi=
ll=20
happily testify that I still spend too much time on it :)

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart51847868.StzgUtFZtW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+Zy+N0y+n1M3mo0RAoTAAJwKUKvgaI9dvZj8bV24MHHDPrlaNACeL+6k
2Om8rkukTrEZVTmi2N9z9Sc=
=LzUo
-----END PGP SIGNATURE-----

--nextPart51847868.StzgUtFZtW--
