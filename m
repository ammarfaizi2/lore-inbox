Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTIOU4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbTIOU4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:56:20 -0400
Received: from dsl093-244-091.ric1.dsl.speakeasy.net ([66.93.244.91]:35305
	"EHLO perl.xsdg.org") by vger.kernel.org with ESMTP id S261582AbTIOUzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:55:49 -0400
Date: Mon, 15 Sep 2003 20:55:46 +0000
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1, -test4 control key "stuck"
Message-ID: <20030915205546.GA12833@perl>
References: <20030915000411.6d35386d.xsdg@freenode.org> <20030915110028.B957@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20030915110028.B957@pclin040.win.tue.nl>
User-Agent: Mutt/1.4i
From: xsdg <xsdg@freenode.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2003 at 11:00:28AM +0200, Andries Brouwer wrote:
::snip? SNIP!::
> Apparently your keyboard has problems handling the situation where many
> keys are down simultaneously.

What would happen if the kernel received two keypress events, and then one =
key-
release event for a single key?  I'd imagine that it'd disregard the duplic=
ate
keypress

>=20
> No kernel problem here - just a confusing message.
::snip? SNIP!::
any idea what might cause the key sticking problem?  I wouldn't think it's
a directly hardware-related problem (though it might be in BIOS firmware, I
suppose) because the problem is resolved when I reboot.

Also, I'm not sure how the final issue I described could have occurred, sin=
ce
it appears to be keymap-related.  Is there some special keycode that might =
be
able to cause a change in the keymap?  Also, does the behavior I described
match any common keymaps?  I typically don't set LANG or any of the other
locale-defining variables.

> Andries
>=20

--=20
| Why do people with closed minds always open their |
|   mouths?                                         |
) http://www.cuodan.net/~xsdg/    xsdg@freenode.org (


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ZidRLa8oArNOsUERAkZzAJ4okH7/uOS/Tzhbz1YYSugkNAyksgCcDZra
wtvIVUbH0Mq6yVdfr2puH9A=
=ylVt
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
