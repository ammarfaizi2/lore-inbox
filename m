Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWC3Lte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWC3Lte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWC3Lte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:49:34 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:46239 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750997AbWC3Ltd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:49:33 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 19:44:23 +1000
User-Agent: KMail/1.9.1
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <200603292050.33622.ncunningham@cyclades.com> <20060330092627.GG8485@elf.ucw.cz>
In-Reply-To: <20060330092627.GG8485@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1251674.j60N08bcuG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603301944.27188.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1251674.j60N08bcuG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 30 March 2006 19:26, Pavel Machek wrote:
> On St 29-03-06 20:50:27, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 29 March 2006 19:19, Pavel Machek wrote:
> > > On =DAt 28-03-06 18:51:51, Mark Lord wrote:
> > > > Nigel Cunningham wrote:
> > > > >Hi everyone.
> > > > >
> > > > >Suspend2, version 2.2.2 is now available from
> > > > >
> > > > >http://stage.suspend2.net/downloads/all/suspend2-2.2.2-for-2.6.16.=
ta
> > > > >r.bz 2
> > > >
> > > > Wow!  Is this ever freaking fast!
> > > > Try it folks.  Once you do, you'll never go back to the slow way!
> > >
> > > Please do try code at suspend.sf.net. It should be as fast and not
> > > needing big kernel patch.
> >
> > Don't bother suggesting that to x86_64 owners: compilation is currently
> > broken in vbetool/lrmi.c (at least).
>
> It seems to work at least for some users. I do not have x86-64 machine
> easily available, so someone else will have to fix that one.
>
> (Also it should be possible to compile suspend without s2ram support,
> avoiding the problem).
> 								Pavel

I just found the line saying pciutils-devel is needed. Maybe that will make=
=20
the difference.

Regards,

Nigel

--nextPart1251674.j60N08bcuG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEK6h7N0y+n1M3mo0RAox9AJwNF9Rl1OqK7C5I3/hmgbTjxAZgJgCghW7J
Xb6kHTkyNwf98h+FzLG1nrc=
=VZUF
-----END PGP SIGNATURE-----

--nextPart1251674.j60N08bcuG--
