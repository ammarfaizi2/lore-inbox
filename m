Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUD3WrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUD3WrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUD3WrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:47:16 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:57514 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261752AbUD3WrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:47:14 -0400
Date: Sat, 1 May 2004 00:47:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Allowing only "-g" compiled modules! (was: [PATCH] Blacklist binary-only modules lying about their license)
Message-ID: <20040430224713.GX29503@lug-owl.de>
Mail-Followup-To: 'lkml - Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <00b201c42eea$916f6c40$ca41cb3f@amer.cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Content-Disposition: inline
In-Reply-To: <00b201c42eea$916f6c40$ca41cb3f@amer.cisco.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-04-30 12:37:26 -0700, Hua Zhong <hzhong@cisco.com>
wrote in message <00b201c42eea$916f6c40$ca41cb3f@amer.cisco.com>:

> user have a choice. A working computer which occasionally crashes is still
> better to the user than a stable computer which doesn't do the job.

WHAT!? I'm sorry, but to my eyes, an unstable computer is worth nothing.
If I can't somewhat trust my machine, I'll take paper and pencil...

However, I don't see a solution towards stopping companies from making
(partially) binary-only drivers.

Maybe we'd start to put more effort into disassemblers/re-assemblers and
code-generators from disassembly dumps.

Maybe we can use a simple solution: Only allow modules that contain full
debug info :)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAktdxHb1edYOZ4bsRAsZEAJwM9zjB/GUs84UEJNVwxpT5nl/EVQCfbw01
eLEkFquhPRPlVi2u/A26tDg=
=XLGt
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--
