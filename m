Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTLPOJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 09:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLPOJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 09:09:15 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:36014 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261659AbTLPOJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 09:09:14 -0500
Date: Tue, 16 Dec 2003 15:08:21 +0100
From: Martin Waitz <tali@admingilde.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
Message-ID: <20031216140821.GA1117@admingilde.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20031215213912.GA29281@codeblau.de> <Pine.LNX.4.53.0312151700320.15531@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZuvoxmZMh0nHqhEq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312151700320.15531@chaos>
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZuvoxmZMh0nHqhEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Dec 15, 2003 at 05:10:00PM -0500, Richard B. Johnson wrote:
> Of course, some root-shell programs bypass the 'C' runtime libraries.
of course, they have to as shellcode won't include a dynamic linker. ;)

so your approach does not help from a security point of view,
and felix only was concerned about security.

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--ZuvoxmZMh0nHqhEq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/3xHVj/Eaxd/oD7IRAiSeAJ46Gd/ETyMkjG1k7O3/cLjSJih6+wCfV0Ef
AYskSYDop2WQG7DAXEesgzA=
=O0jr
-----END PGP SIGNATURE-----

--ZuvoxmZMh0nHqhEq--
