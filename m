Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVBCAYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVBCAYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVBCAWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:22:31 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:10259 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262328AbVBCAVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:21:44 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, michal@logix.cz, dm-crypt@saout.de
In-Reply-To: <20050202153449.1e92c29a.davem@davemloft.net>
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
	 <1107386909.19339.9.camel@ghanima>
	 <20050202153449.1e92c29a.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cAOulUBUAb9gA8QXvomO"
Date: Thu, 03 Feb 2005 01:21:35 +0100
Message-Id: <1107390095.19339.26.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cAOulUBUAb9gA8QXvomO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-02 at 15:34 -0800, David S. Miller wrote:

> Also, I think there will be objections to that studlyCaps naming you
> said your other code has.  Keep garbage like that in the x11 sources,
> if you don't mind :-)

I'm afraid, I'm not going to change it. I already lost too much time
pushing LRW into the kernel.=20

Coding time: 3 days. Pushing time: 78 days and counting.=20

I'm willing to cancel my work, as I've taken this to matter to an
extend, where my time sacrifice can hardly be justified. Especially, if
James ask me to redo Michal's conflicting patches (done btw), which are
totally off-topic for me. Then, I'm certainly not going to redo all my
code, just because someone thinks different about the naming of my
variables.
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-cAOulUBUAb9gA8QXvomO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAW6PW7sr9DEJLk4RAkRRAJ92N/r1UP6qoWKt2Y0c9XixVZOvIgCeMp70
hljd0Kq6FL1yylP5uzjVnCc=
=He0A
-----END PGP SIGNATURE-----

--=-cAOulUBUAb9gA8QXvomO--
