Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUFRFy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUFRFy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUFRFy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:54:58 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:62154 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262103AbUFRFyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:54:55 -0400
Date: Fri, 18 Jun 2004 07:54:54 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618055454.GS20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <40D232AD.4020708@opensound.com> <77709e76040617180749cd1f09@mail.gmail.com> <40D24163.5000006@opensound.com> <1087522622.5475.30.camel@louise3.6s.nl> <40D24963.7040003@opensound.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gA6UC8XTb9NkxZ9U"
Content-Disposition: inline
In-Reply-To: <40D24963.7040003@opensound.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gA6UC8XTb9NkxZ9U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-06-17 18:46:11 -0700, 4Front Technologies <dev@opensound.com>
wrote in message <40D24963.7040003@opensound.com>:


> What's with you guys?. Would you really like to see Linux forking?

I like playing with non-i386 hardware, that is, I do have (at least) one
"forked" kernel for each architecture, possibly even more than one...
It's just that --most of the time-- it's missing time that leads to
forked trees (that need unification some time after...).  Bet on it, I'd
really like getting hired for keeping an eye on all those trees and
working on reviewing/merging them all back to Linus' tree! It's probably
nothing different with the SuSE kernels. You've hit a bug here, so let's
solve that. But their large patch set won't go away completely:

	- Legacy drivers ported from 2.2.x and 2.4.x? Customer should
	  use newer drivers.
	- Bugs fixed? Bugfix needs review and merge! (Hire me, if you can:)
	- New drivers? Review and merge!
	- New features that touch all the kernel? Needs a lot of
	  discussion...

So, some parts are easy, some are not. Your problem's bugfix for sure
isn't hard to do, but large chunks of their patch may need *long*
lasting discussion...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--gA6UC8XTb9NkxZ9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0oOuHb1edYOZ4bsRAhWCAJ4xcJlASi7mljEwcrAzfy3KDPZG/ACeL8ZN
+v440iikEfctNUD2lJLoNlU=
=ZWqO
-----END PGP SIGNATURE-----

--gA6UC8XTb9NkxZ9U--
