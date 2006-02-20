Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWBTLon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWBTLon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWBTLon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:44:43 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:21166 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932601AbWBTLom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:44:42 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 21:24:26 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Pavel Machek <pavel@suse.cz>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe>
In-Reply-To: <1140434146.3429.17.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1370947.tkvPQFKogo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602202124.30560.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1370947.tkvPQFKogo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 21:15, Lee Revell wrote:
> On Mon, 2006-02-20 at 11:33 +0100, Matthias Hensler wrote:
> > That is all I
> > complain about, it means throwing away everything that is working, or
> > easy to get it working, and delaying working hibernate support for
> > another time.
>
> But we have not established that the current implementation does not
> work!  That's a pretty strong assertion to make with zero evidence.

=2E..and that requires defining 'works'.

If we define it as "writes an image of some part of ram to a swap partition=
=20
that can be and does normally get restored on the next boot", then yes, we=
=20
have a working version in the existing vanilla kernel. If however you start=
=20
talking about multiple swap partitions or swap files or ordinary files, abo=
ut=20
reliability or the ability to tune it to fit your system and preferences,=20
about the responsiveness of the system post resume or the security of the=20
image (IIRC, encryption support has just been removed from swsusp), about t=
he=20
ability to get help when you run into trouble or documentation, swsusp=20
becomes less of a candidate for 'works'.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1370947.tkvPQFKogo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+abuN0y+n1M3mo0RAs7uAKCf+6TgqDtoTAS/GooR6yRfwWjH4ACg1zjr
kXMXy0gNM3rdmujvcnuDEHo=
=4jv/
-----END PGP SIGNATURE-----

--nextPart1370947.tkvPQFKogo--
