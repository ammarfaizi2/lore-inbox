Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTGSSG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGSSG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:06:27 -0400
Received: from main.gmane.org ([80.91.224.249]:48826 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270436AbTGSSG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:06:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Suspend on one machine, resume elsewhere
Date: Sat, 19 Jul 2003 11:22:18 -0700
Message-ID: <m2r84m8jhh.fsf@tnuctip.rychter.com>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk>
 <20030716104026.GC138@elf.ucw.cz>
 <20030716195129.A9277@informatik.tu-chemnitz.de>
 <20030716181551.GD138@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:hkpjbhTy31CAjzkgoABtA32xolg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

>>>>> "Pavel" =3D=3D Pavel Machek <pavel@suse.cz> writes:
 Pavel> Hi!
 > If you want to migrate programs between machines, run UMLinux, same
 > config, on both machines. Ouch and you'll need swsusp for UMLinux,
 > too
 >>
 >> That might be more important than you think.

 Pavel> :-). Well, it is also harder than you probably think, because
 Pavel> UML is *very* strange architecture and it is not at all easy to
 Pavel> save/restore its state. There were some patches in that area,
 Pavel> but it never worked (AFAIK).

... but there are many people who dream about swsusp for UMLinux.

Particularly some laptop users who want to suspend (at least the most
critical long-running applications) and/or find Linux way too unstable
and requiring frequent reboots.

The day UMLinux gets swsusp, I'm moving my XEmacs, mozilla and some
other toys into a UML machine and staying there. Hopefully then a single
problem with a USB driver, keventd running wild, or other frequently
encountered breakage won't be taking my entire world down.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GYxaLth4/7/QhDoRAoYMAJ92FO2kpJfbOQKo7UgbHHrpvDYVagCgw+np
wCM8vhQHGNND6dUaToE/oxs=
=whJn
-----END PGP SIGNATURE-----
--=-=-=--

