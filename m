Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTEEJTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTEEJTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:19:49 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:34543 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262115AbTEEJTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:19:48 -0400
Subject: Re: The disappearing sys_call_table export.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: D.A.Fedorov@inp.nsk.su
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.10.10305051545480.8168393-100000@Sky.inp.nsk.su>
References: <Pine.SGI.4.10.10305051545480.8168393-100000@Sky.inp.nsk.su>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3lLrwlmDDiGdk5dzBjUP"
Organization: Red Hat, Inc.
Message-Id: <1052127131.1459.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 05 May 2003 11:32:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3lLrwlmDDiGdk5dzBjUP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-05 at 11:01, Dmitry A. Fedorov wrote:

> But why module should not have ability to call any function which is
> available from user space?

that's you you can just call sys_read() and co directly.


--=-3lLrwlmDDiGdk5dzBjUP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ti+bxULwo51rQBIRAo06AJwKHjWV4FNHFThvXT/yBcCnIbv1VQCgkjT7
If7j68FPaGZE14O2kVV/FgA=
=YijF
-----END PGP SIGNATURE-----

--=-3lLrwlmDDiGdk5dzBjUP--
