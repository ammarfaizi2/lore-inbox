Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWGYVXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWGYVXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGYVXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:23:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964860AbWGYVXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:23:09 -0400
Message-ID: <44C68C0D.6030100@redhat.com>
Date: Tue, 25 Jul 2006 14:24:29 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: async network I/O, event channels, etc
References: <44C66FC9.3050402@redhat.com> <20060725132554.38773695@localhost.localdomain>
In-Reply-To: <20060725132554.38773695@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig821231FE83319E4293C24A7A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig821231FE83319E4293C24A7A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Stephen Hemminger wrote:
> I would prefer directing the API discussion to netdev@vger.kernel.org

This is for the actual async network I/O.  I certainly can agree with
this.  The other parts are not exclusively or even mainly interesting
for networking and likely should be discussed elsewhere.  And the net
aio stuff depends on the other two parts.  netdev would certainly be my
last choice but if this is what people want, so be it.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig821231FE83319E4293C24A7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFExowN2ijCOnn/RHQRAjSVAJ489leE55Y0XYnm7b2Y3Q5eWC8jUQCfWDvF
z3IG0DgcCCmuZOwEiJRx+PM=
=P/cl
-----END PGP SIGNATURE-----

--------------enig821231FE83319E4293C24A7A--
