Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWCHXhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWCHXhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWCHXhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:37:34 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:44216 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932249AbWCHXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:37:32 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Nigel's work and the future of Suspend2.
Date: Thu, 9 Mar 2006 09:34:33 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603071005.56453.nigel@suspend2.net> <440DE40F.6090107@tmr.com>
In-Reply-To: <440DE40F.6090107@tmr.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6062874.gH0D5iHUk9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603090934.38256.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6062874.gH0D5iHUk9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 08 March 2006 05:50, Bill Davidsen wrote:
> > Users of Suspend2 can rest assured that I will not allow the patches to
> > suffer bitrot. I will be continuing to use them myself, and will
> > therefore have the best of incentives to keep them up-to-date.
>
> I think you for all your work, and I hope that your new calling will be
> satisfying!

Thanks :)

> > Now for the downside: I won't, however, be making any sort of concerted
> > effort at getting them merged into the vanilla kernel after my move, and
> > am not inclined to make a big effort beforehand. Recent discussions on
> > LKML clearly showed that Pavel doesn't want to see them merged, and I
> > didn't see much in the way of other kernel developers expressing a desi=
re
> > contrary to Pavel's wishes. I don't want to waste my time and effort, so
> > I don't see the point to doing anything but maintaining the patches as
> > they stand.
>
> I have never had any problems with Suspend1 in terms of SUSPEND,
> although I was hoping at some time that RESUME functionality would be
> added as well ;-) Suspend2 has worked for my laptops, and I'm delighted
> that you will be continuing your work.

I don't think of swsusp as suspend1 - in my mind, Suspend1 was the version =
I=20
released before suspend2 :). That said, I obviously know what you mean. It=
=20
should work - they're basically the same. The main difference that would ma=
ke=20
Suspend2 work for you would be that I've sometimes included the odd driver=
=20
fix in the suspend2 patch to save people having to go searching, and have (=
my=20
bad) been too slow at pushing them upstream.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart6062874.gH0D5iHUk9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBED2oON0y+n1M3mo0RAivgAJ4mk64zPPRUFSyDmmWvv2+I6GbZDACgoIQv
wpOHUrEkZ1KU+67B6v0xcWA=
=H2Z6
-----END PGP SIGNATURE-----

--nextPart6062874.gH0D5iHUk9--
