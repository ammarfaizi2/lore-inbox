Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVHQNQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVHQNQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVHQNQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 09:16:49 -0400
Received: from mail.murom.net ([213.177.124.17]:9100 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S1751117AbVHQNQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 09:16:48 -0400
Date: Wed, 17 Aug 2005 17:16:00 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mathias Kretschmer <posting@blx4.net>,
       linux-kernel@vger.kernel.org
Subject: Re: VIA VT6410 IDE support for 2.6.11-rc3/via82cxxx
Message-ID: <20050817131600.GE11523@procyon.home>
References: <41A2E581.2010305@blx4.net> <41A38128.90305@pobox.com> <41A3A238.3070003@blx4.net> <4206A1F5.6050305@blx4.net> <4207A268.3040804@blx4.net> <4207A513.10601@pobox.com> <58cb370e0502111033677d9a2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <58cb370e0502111033677d9a2d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(sending this again, because did not see the message in linux-kernel
for 2 days and suspect that it has been lost; sorry if someone
receives a duplicate)

On Fri, Feb 11, 2005 at 07:33:59PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Mon, 07 Feb 2005 12:27:47 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Mathias Kretschmer wrote:
> > > Mathias Kretschmer wrote:
> > >> Mathias Kretschmer wrote:
> > >>> Jeff Garzik wrote:
> > >>>> Mathias Kretschmer wrote:
> > >>>>> hi,
> > >>>>>
> > >>>>> I found an older version of this patch (against 2.4.22) on some
> > >>>>> website. After a little bit of editing it applied cleanly to 2.4.=
27
> > >>>>> (and now 2.4.28). It works fine for me on a ASUS P4P800-Deluxe wi=
th
> > >>>>> 4x 300GB disks.
> > >>>>>
> > >>>>> Maybe someone finds this patch helpful. Any reason why the origin=
al
> > >>>>> patch did not make it into the kernel ?
> > >>>>
> > >>>> Why not add it to the existing via82cxxx driver, and get better
> > >>>> performance and device tuning?
> > >>
> > >> OK, the attached patch adds support for the VIA 6410 chip to the
> > >> via82cxxx driver (instead of the generic driver).
> > >> I've tested it on the board mentioned above. Works fine for me.
> > >
> > > as above, but for 2.6.11-rc3
> >=20
> > Bart, got this one?
>=20
> I applied it (after whitespace cleanup) to ide-dev-2.6.

Sorry to bother you, but what's the status of this patch?  Since that
time, 2.6.11 and 2.6.12 kernels were released, now 2.6.13 is almost
ready, and the VT6410 support does not seem to appear even in -mm.
Has the patch been lost, or is it broken?

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDAziQW82GfkQfsqIRAuzIAJ4gF/QWYa2yqxJaGjZYnDZs6gUL5gCeITEF
wagJaKoAsoiWm+TMsQB/kV8=
=BD/8
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
