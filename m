Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWBGWnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWBGWnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWBGWno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:44 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:53979 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030181AbWBGWnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:18 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 19:36:45 +1000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Jim Crilly <jim@why.dont.jablowme.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139282224.2041.48.camel@mindpipe> <20060207093317.GB1742@elf.ucw.cz>
In-Reply-To: <20060207093317.GB1742@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14075033.3z5NXcOs7S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071936.52245.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart14075033.3z5NXcOs7S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 19:33, Pavel Machek wrote:
> On Po 06-02-06 22:17:04, Lee Revell wrote:
> > On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> > > With uswsusp it'll be more flexible in that you'll be able to use any
> > > userland process or library to transform the image before storing it,=
 but
> > > the suspend and resume processes are going to be a lot more complicat=
ed.
> > > For instance, how are you going to tell the kernel that you need the
> > > uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run after the rest of
> > > userland has been frozen?
> >=20
> > Unless someone at least gives a rough estimate of 1) what % of users
> > can't suspend their laptops now and 2) of these, what % are helped by
> > suspend2, this thread is just handwaving...
>=20
> and 3) for what % of users, suspend2 will actually break it (bugs
> happen).
>=20
> Anyway it seems to be something like 1) 90% 2) 1% 3) .5%

And the source for your numbers is?....

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart14075033.3z5NXcOs7S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6Go0N0y+n1M3mo0RAgRPAJ0ZcPXflbSNJkPNkh/QyFvTFlBJqACfTjtE
m1iqo/qfuuL4qRZeBl4fzp4=
=VhOv
-----END PGP SIGNATURE-----

--nextPart14075033.3z5NXcOs7S--
