Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTHOQoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270605AbTHOQoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:44:39 -0400
Received: from adsl-67-121-155-84.dsl.pltn13.pacbell.net ([67.121.155.84]:42158
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S270082AbTHOQnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:43:02 -0400
Date: Fri, 15 Aug 2003 09:43:00 -0700
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030815164300.GA31121@triplehelix.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60> <20030815111442.A12422@flint.arm.linux.org.uk> <0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2003 at 09:39:07PM +0900, Norman Diamond wrote:
> I will do that in my next build.  For some reason I wasn't sure if yenta
> would handle 16-bit cards.  But this turns out not to be necessary.  Also
> the PCMCIA suggestions which Felipe Alfaro Solana suggested (the suggesti=
ons
> which I intended to try) turned out not to be necessary.  The winner is t=
he
> next one:

Note that if you don't already have CONFIG_ISA enabled, 16-bit CardBus
devices will refuse to work.

--=20
Joshua Kwan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iQIVAwUBPz0Nk6OILr94RG8mAQJsQA//a20gnaWUrIp/jqJuyjOwd1mLjPhoUML8
LkLcWhjd3VgzYkah7E7hAhyKvJW+efXIoNR8AfcmUqO6MtaMP1K4tJ0ccZxxK3Nu
gpyFwnV2YsYTCSyUebWm6ZtYcXIKGRtr3/X8Wtlhrr2SG+2EEYTI14aVSL+etW/k
JuMwE8cUetS0Q5gNwFhyQiphgSBX4fidybJHZcftLNNwgzGBlwcPX9tBGq46Noqi
/fsjHOj2AQbC0NEeQV7ZzZBDsaRwZxdvwgOYTz2cpdyKYEA1Vwoy053Y0VwRCOxt
Qat1GHStB6uM2AOmxKzSuD7glvoS3Z9v428xeheC2oBgMBeRZlTiI5B8PelQzDwH
4AR6+rXG+LKHMWQzce+5IATB2eB+3uUevLD10SsvH3pmJTHoIRMSpgEwXZFI6HTJ
RoP+0fNvIv/rthP04BnOH0m1+z+UiU0Ajhzru9LO08QIsA16FWimp4pHYLnWbXHs
0ziPYrQaPqcAoCl3qDPOY7cj9zOdymggYIWQ9MIv63+L9Jbp0t++VMST0g8gK+5D
yzkY1VhmoGe3frZio3/bE3x8ve6N6kdlWHus2b4kPnsJ+U78DnneWBq8eg3ZkzRx
BeR5K2uR1fnI9v/0XpKuNydNzKiP6xBjia3WtoQ4jsNYg0ytBqWzSE1ootJm2rCN
ppkxA9ogMs0=
=0cmk
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
