Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWBCBfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWBCBfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBCBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:35:43 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:54243 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932187AbWBCBfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:35:42 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 11:32:13 +1000
User-Agent: KMail/1.9.1
Cc: Bojan Smojver <bojan@rexursive.com>, suspend2-devel@lists.suspend2.net,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060203120055.0nu3ym4yuck0os84@imp.rexursive.com> <20060202171812.49b86721.akpm@osdl.org>
In-Reply-To: <20060202171812.49b86721.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1278696.RJXEEoIoTy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602031132.18512.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1278696.RJXEEoIoTy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again.

On Friday 03 February 2006 11:18, Andrew Morton wrote:
> Bojan Smojver <bojan@rexursive.com> wrote:
> > Bottom line: With your code, my machine works. Without it, it doesn't.
>
> This leaves us in rather awkward position.  You see, there will be other
> people whose machines don't work with suspend2 but which do work with
> swsusp.  And other people who prefer swsusp for other reasons.
>
> It'd help if we knew _why_ your machine doesn't work with swsusp so we can
> fix it.  Futhermore it'd help if we knew specifically what you prefer abo=
ut
> suspend2 so we can understand what more needs to be done, and how we shou=
ld
> do it.

As much as I appreciate Bojan's comments, I want to ask the same question -=
=20
when it comes to driver model invocations and the method of restoring the=20
original kernel data, swsusp and Suspend2 work in almost exactly the same=20
way, so if one works for someone, the other should too and vice versa.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1278696.RJXEEoIoTy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4rKiN0y+n1M3mo0RAhroAJ4jNPPW8YRaUyzZSUW2372EHB9bsgCg9iDm
f8ODp9bCx457Ldhg6wtZYDI=
=epg9
-----END PGP SIGNATURE-----

--nextPart1278696.RJXEEoIoTy--
