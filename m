Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTGAJyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTGAJyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:54:52 -0400
Received: from mx02.qsc.de ([213.148.130.14]:55521 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261876AbTGAJyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:54:49 -0400
Date: Tue, 1 Jul 2003 12:12:40 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Message-ID: <20030701101238.GB686@gmx.de>
Reply-To: Johoho <johoho@hojo-net.de>
References: <200307010944.46971.kernel@kolivas.org> <200307010952.26595.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <200307010952.26595.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.5.73-bk7-O1int0307010949 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jul 01, 2003 at 09:52:26AM +1000, Con Kolivas wrote:
> On Tue, 1 Jul 2003 09:44, Con Kolivas wrote:
> > Here is an evolution of the O1int design to minimise audio skips/smooth=
 X.
> > I've been forced to work with even less sleep than usual because of this
> > but I'm getting quite happy with it now.
=20
for normale usage I'm happy with it, even under heavy load (two kernel
compiles with -j4 on a single processor machine) I can type into my
xterms mostly instantly.
However starting new applications/xterm's is a pain, a plain xterm which
starts normally within a second takes about 3-5secs. Openoffice isn't
usable at all. But on the other side I normally don't compile with
-j4...
However the xmms didn't skip once while playing. I applied this patch
ontop of 2.5.73-bk7.


--=20
Regards,

Wiktor Wodecki

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/AV6W6SNaNRgsl4MRAtXpAJ0Y8ukTTS4Y+aMTmAtnwsQ/a6hfSgCeLhwj
qDe4U3ZTnlxfU5TPDNhcKPs=
=H55U
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
