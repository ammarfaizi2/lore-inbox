Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWAaPEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWAaPEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWAaPEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:04:16 -0500
Received: from lug-owl.de ([195.71.106.12]:47547 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750873AbWAaPEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:04:15 -0500
Date: Tue, 31 Jan 2006 16:04:13 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, dirk@opfer-online.de,
       jbowler@acm.org
Subject: Re: [PATCH 0/11] LED Class, Triggers and Drivers
Message-ID: <20060131150413.GY18336@lug-owl.de>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>, John Lenz <lenz@cs.wisc.edu>,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
	tglx@linutronix.de, dirk@opfer-online.de, jbowler@acm.org
References: <1138714882.6869.123.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAPpM8TI9SUHvGJT"
Content-Disposition: inline
In-Reply-To: <1138714882.6869.123.camel@localhost.localdomain>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAPpM8TI9SUHvGJT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-31 13:41:22 +0000, Richard Purdie <rpurdie@rpsys.net> wrote:
> This is an updated version of the LED class/subsystem I proposed a while
> ago. It takes John Lenz's work and extends and alters it to give what I
> think should be a fairly universal LED implementation.

I'd abandon my own LED implementation I wrote for the status LEDs of
some VAXen, though it cannot substitute it fully (eg. there are some
7-segment displays using bitmasks _or_ 0x00..0x0f for the bars) once
some small tweaks are done (which I just sent with the other emails.)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--uAPpM8TI9SUHvGJT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD33xtHb1edYOZ4bsRAv+KAJ0dUcrTVcfdtnYaFNINrfWuRDg8pwCfb/uR
d7GhmlXcOwONan/TeMEwzHk=
=TUL3
-----END PGP SIGNATURE-----

--uAPpM8TI9SUHvGJT--
