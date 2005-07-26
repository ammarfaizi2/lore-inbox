Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVGZURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVGZURs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVGZUPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:15:34 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:44940 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261998AbVGZUPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:15:20 -0400
Date: Tue, 26 Jul 2005 22:15:06 +0200
From: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
To: mkrufky@m1k.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
In-Reply-To: <42E692E4.4070105@m1k.net>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__26_Jul_2005_22_15_07_+0200_dvpef7=Sd0fJ7WZi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__26_Jul_2005_22_15_07_+0200_dvpef7=Sd0fJ7WZi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Jul 2005 15:45:41 -0400
Michael Krufky <mkrufky@m1k.net> wrote:

> I have filters set up so that my mailer puts all mm-commits messages=20
> from the mailing list into a special "mm-commits" folder.  Each time=20
> Andrew releases an -mm kernel, I rename my "mm-commits" folder to=20
> "mm-commits-%version%", such as "mm-commits-2.6.13-rc3-mm2"  (I will=20
> probably have to create a folder like this tomorrow, or in a few=20
> hours/days ;-) ... Then I create a new "mm-commits" folder to hold all=20
> new patches not yet in the latest -mm kernel.  As of right now, my=20
> current "mm-commits" mail folder has 153 patches in it, although I think=
=20
> I may have lost a patch or two...

The problem is detecting if or when the latest -mm got created.
If I have to do it by hand, it becomes a major PITA.
I could use RSS to do this, but some patches may still hit the wrong
folder. What's more it would create unnecessary network load.
There are sometimes only a few minutes between "patch in -mm1"
and "patch in -mm2".

--=20
AstralStorm

GPG Key ID =3D 0xD1F10BA2
GPG Key fingerprint =3D 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2
Please encrypt if you can.

--Signature=_Tue__26_Jul_2005_22_15_07_+0200_dvpef7=Sd0fJ7WZi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFC5pnSlUMEU9HxC6IRArF7AJ4ioqJt0I0w2ouvDQOyYGB4C+ayHgCgifWH
3QQ+z/RcUBsKFg/o3sxVy8U=
=vde5
-----END PGP SIGNATURE-----

--Signature=_Tue__26_Jul_2005_22_15_07_+0200_dvpef7=Sd0fJ7WZi--
