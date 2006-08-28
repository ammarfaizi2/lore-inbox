Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWH1Lkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWH1Lkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWH1Lkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:40:42 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:41369 "EHLO
	mail.arcor.de") by vger.kernel.org with ESMTP id S964836AbWH1Lkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:40:41 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Valerie Henson <val_henson@linux.intel.com>
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Date: Mon, 28 Aug 2006 13:40:26 +0200
User-Agent: KMail/1.9.4
Cc: Pozsar Balazs <pozsy@uhulinux.hu>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <20050427124911.6212670f@griffin.suse.cz> <200608231859.32304.prakash@punnoor.de> <20060824172347.GA24434@goober>
In-Reply-To: <20060824172347.GA24434@goober>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1598133.lTIfM6dPXV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608281340.26913.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1598133.lTIfM6dPXV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 24 August 2006 19:23 schrieb Valerie Henson:
> On Wed, Aug 23, 2006 at 06:59:32PM +0200, Prakash Punnoor wrote:
> > Am Samstag 19 August 2006 02:16 schrieb Valerie Henson:
> > > Hey folks,
> > >
> > > Added to my to-do list.  Let me know if you figure out anything else.
> >
> > As it comes back to my mind: Last time I tested dhcpcd doesn't work.
> > dhclient does, but takes a lot of time. (The dhcp server is debian
> > based.) Other cards don't have a problem. They get their ip assigned fa=
st
> > and with either dhcpocd or dhclient.
>
> Tcpdump on client and server, please?

Hi, I couldn't try earlier. Since I noticed the server generates a very big=
=20
log in short time, so I think the irrelevant infos should be filtered out -=
=20
it is simply to big to post. As I never used tcpdump, could you give me an=
=20
example how to accomplish this?

Thx,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1598133.lTIfM6dPXV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE8tYqxU2n/+9+t5gRAtx8AJ9yUj1ujFJkelaHWYBAQjSOLAkJsQCcDh30
wGoqLNDBQI1QJ0OqBnnqvLA=
=PgE5
-----END PGP SIGNATURE-----

--nextPart1598133.lTIfM6dPXV--
