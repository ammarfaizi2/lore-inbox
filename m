Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUA0Tgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUA0Td7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:33:59 -0500
Received: from mail-in.m-online.net ([62.245.150.237]:24553 "EHLO
	mail-in.m-online.net") by vger.kernel.org with ESMTP
	id S265639AbUA0Tbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:31:49 -0500
Subject: Re: Synaptics problems with kernel 2.6.x
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Cc: Richard Kuryk <rkuryk@comcast.net>
In-Reply-To: <1075171320.25088.46.camel@localhost>
References: <1075171320.25088.46.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zsAhkc14u/+c/gQNBq7b"
Message-Id: <1075231908.11207.88.camel@suprafluid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 20:31:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zsAhkc14u/+c/gQNBq7b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-27 at 03:42, Richard Kuryk wrote:

> I have been reading prior messages so I know there are issues with power
> management and ACPI and I have tried them on/off it doesn't really
> help.=20

Do you have a tool that polls apm/acpi info very often? (like gkrellm
apci plugin). I switched this off and now my tp is workling correctly.

HTH

--=20
Florian Huber

Key ID: D9D50EA2
Fingerprint: 0241 C329 E355 9B94 8D34 F637 4EB9 1B1D D9D5 0EA2

BOFH Excuse #379:
We've picked COBOL as the language of choice.

--=-zsAhkc14u/+c/gQNBq7b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFrykTrkbHdnVDqIRAmlFAJ9EVr3YZzlLydqWOjXuUhFJQ/2ESwCfetdi
8JhkP8bLsPP7G1DNxx5lP9M=
=tCfy
-----END PGP SIGNATURE-----

--=-zsAhkc14u/+c/gQNBq7b--

