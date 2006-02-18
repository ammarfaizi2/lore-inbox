Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWBRAoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWBRAoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWBRAoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:44:17 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:28565 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751081AbWBRAoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:44:16 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Richard Mittendorfer <delist@gmx.net>
Subject: Re: [swsusp] not enough memory
Date: Sat, 18 Feb 2006 10:41:07 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060218005814.6548092d.delist@gmx.net> <200602181008.02801.ncunningham@cyclades.com> <20060218014054.15bfc4f5.delist@gmx.net>
In-Reply-To: <20060218014054.15bfc4f5.delist@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2144234.o9oTrakfpH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602181041.11676.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2144234.o9oTrakfpH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Saturday 18 February 2006 10:40, Richard Mittendorfer wrote:
> Also sprach Nigel Cunningham <ncunningham@cyclades.com> (Sat, 18 Feb
>
> 2006 10:07:58 +1000):
> > Hi Richard.
>
> Hello Nigel,
>
> > On Saturday 18 February 2006 09:58, Richard Mittendorfer wrote:
> > > swsusp: Need to copy 15526 pages
> > > swsusp: Not enough free memory
> > > Error -12 suspending
> > > [...]
> >
> > swsusp needs to be able to free half your memory to be able to
> > suspend. I  don't know it intimately, but you may well be failing to
> > do this. Being  completely biased (and not unwilling to admit it!),
> > I'd suggest you try  Suspend2 (www.suspend2.net). It doesn't have such
> > a limitation.
>
> Thanks for this hint. However, I'm using ck's patches and having errors
> compiling sched.c. Just took a quick look: I don't think I can get them
> working together. The  rest of the suspend2 patch (for 2.6.15.1) seems
> to apply fine to 2.6.15.4 also (Not much changes IIRC).

http://iphitus.loudas.com/archck.php contains both Con's patches and Suspend2.

Regards,

Nigel

> > Regards,
> >
> > Nigel
>
> sl ritch

--nextPart2144234.o9oTrakfpH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD9m0nN0y+n1M3mo0RAk08AJ9efFF9RqF1nuflzasVmRqP5qtevQCeK4OV
jWuIf//N7gXLElprA9kIlOU=
=yGnk
-----END PGP SIGNATURE-----

--nextPart2144234.o9oTrakfpH--
