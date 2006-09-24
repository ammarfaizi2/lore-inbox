Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWIXJ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWIXJ3b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 05:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWIXJ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 05:29:31 -0400
Received: from cweiske.de ([80.237.146.62]:40347 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S1751909AbWIXJ3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 05:29:31 -0400
Message-ID: <45165027.3040208@cweiske.de>
Date: Sun, 24 Sep 2006 11:30:15 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de> <20060923134244.e7b73826.akpm@osdl.org> <45164BA6.60200@cweiske.de>
In-Reply-To: <45164BA6.60200@cweiske.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCB9758878A0453097C420314"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB9758878A0453097C420314
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> I put the logs in a tar.bz2 because I didn't want to flood the list wit=
h
> a 200k message.

In case the bz2 didn't make it through the list:
http://xml.cweiske.de/dojo%20kernelpanic%20+%20debug.tar.bz2

--=20
Regards/MfG,
Christian Weiske


--------------enigCB9758878A0453097C420314
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFFlArFMhaCCTq+CMRAlUjAKDC8mPwnP28XXQ04Pg4M9FFvJeE1wCgzwO5
RjLybgOZ+o8AgBWANfasUM0=
=g+YY
-----END PGP SIGNATURE-----

--------------enigCB9758878A0453097C420314--
