Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTKNHON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 02:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTKNHON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 02:14:13 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:8064 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262181AbTKNHOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 02:14:11 -0500
Date: Fri, 14 Nov 2003 08:14:10 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114071409.GF17497@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311130910310.1809-100000@bigblue.dev.mdolabs.com> <3FB3CB96.9080507@tupshin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL3CgPauyjmRqeXN"
Content-Disposition: inline
In-Reply-To: <3FB3CB96.9080507@tupshin.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jL3CgPauyjmRqeXN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-13 10:21:10 -0800, Tupshin Harper <tupshin@tupshin.com>
wrote in message <3FB3CB96.9080507@tupshin.com>:
> Davide Libenzi wrote:
> >Larry, if there are really six users (i'm one of them, rsync) among=20
> >pserver and rsync access, I am the first to tell you shut it down. It is=
=20
> >not worth. On the other hand IIRC it was you that, when Pavel showed up=
=20
> >with the bitbucket hack to extract metadata from BK, volunteered to do i=
t=20
> >internally inside BM. Do I remember correctly?
> As one of the six, I would happily 2nd the shutting down of the=20
> pserver...rsync is fine with me. I would actually prefer no CVS archive=
=20
> at all as long as the raw changesets were rsyncable...then the community=
=20
> would be responsible for doing something useful with them instead of BM.

That would be fine with me, too, but there's one little drawback: The
changeset format. You can't simply use a patch(1) file because there is
a (really little) number of non-text files in the kernel source tree
that won't diff...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--jL3CgPauyjmRqeXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tIDBHb1edYOZ4bsRAoyDAJoDwS+6hWf8wAeyEX5klOSH59kW5ACfUZof
UcV+Lj9FBXaOG/3gqRnvMjU=
=wxS/
-----END PGP SIGNATURE-----

--jL3CgPauyjmRqeXN--
