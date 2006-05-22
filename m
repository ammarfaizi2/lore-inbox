Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWEVPZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWEVPZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWEVPZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:25:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:54238 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750899AbWEVPZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:25:45 -0400
X-Authenticated: #2308221
Date: Mon, 22 May 2006 17:25:31 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Jan Knutar <jk-lkml@sci.fi>, Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060522152531.GB4538@hermes.uziel.local>
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <Pine.LNX.4.61.0605220908580.26879@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605220908580.26879@chaos.analogic.com>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2006 at 09:29:58AM -0400, linux-os (Dick Johnson) wrote:
> On Mon, 22 May 2006, Jan Knutar wrote:
> > I thought deep discharge cycles were unhealthy for lead batteries?
>=20
> Yes. It's some of the more modern chemistries that need deep discharges
> because they tend to "remember".

And if you truly deep discharge them, they drop dead and won't remember
they've been charged. Topping off won't do any good either. So there's
some security margin your daily e.g.  LiIon appliance in your cellphone
will force upon you, in order to keep the battery alive. You can turn
the thing on over and over, but it will shut down on you after seconds.
It just won't suck the thing dry. And the charging process will be
stopped slightly before the battery is entirely full, to avoid
overcharge.

> Lead acid batteries, both wet cells and gel cells should be taken down
> to about 66 percent capacity and that's 66 percent capacity, not some
> arbitrary voltage. For instance, a 24 ampere-hour battery, fully
> charged at 25 degC, has a terminal voltage of 13.2 volts after the
> load is applied. Presumably it contains 13.2 * 24 * 3600 =3D 1,140,480
> joules (watt-seconds) of energy. You get to use 66 percent of this,
> i.e., 752,717 joules before it needs charging. You can't detect the
> charge state by looking at the terminal voltage! You need to actually
> measure the voltage and current during charge and discharge to
> maintain battery health. Otherwise, you just throw them away every
> year or so. The telephone company has lead-acid batteries that have
> been running for 50 years and they will be good "forever" because they
> carefully (automatically) maintain them.

Except for the slow and irreversible chemical transformations at the
poles, I guess. Acid is corrosive, after all. So with careful handling,
those things last a long time, but not forever, unfortunately. But the
approximation is good enough, anyway.

So it appears to me that those lead acid beasts make up a rather
constant source of DC - with other solutions the state can be measured
by means of voltage alone. But the circuitry might be a bit more
complicated for this exact reason. Do you by any chance know where I
might look for schematics of such circuitry? Any hint greatly
appreciated : )

Kind regards,
Chris

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHHX6l2m8MprmeOlAQJD+w//QCiPTa9xDseM8+Ic6bsGSVDT71eC425o
kun4N+gNe9hmwOUmjZn0D9obzky521/3K+k3HXfycJwM0kqMWK2bKXhVNFrPtGLS
gUfUksYX0PWf9Fbhm6ITSb6CUs1gaGFHSDTO9I0Vb8UZt9OcS28VZOtUkHKnW7MY
4RZD6wegNfbAS7s7SfUBYLULTajF/ZWQz6NtduO3U9L+/IVfhnfTOWq4X8vrzySK
Tzf6H41aNfCqcrhwGV8bVW7GlqvmiecwSdQ2P+rmZUjKQgs3mL3lRg8tOwJehPih
mS0Fgf/u5g4GKcUnM78AhmxMp+uTo4x4FtJ1YegHwjtpgmZonx7NzTDaL0QX0HVP
OrQQTmSrrQZsCA0ycKlMHpY1uMV7vH2x/y7Loa6a2faYkfeJwcOv942yj7C8Oadh
9JfoFGLr0OvckJd6lyLsFJjZiuxoffaMPd6NYRcHRW2gsrPmcrzd7bF/6KUjeuAb
FjTgCdb8q5UN2jl23pJ0r0vkPPwZ1dCfFABWFtcUvAQdMbd6BrRjKK3QsuxisOpG
shHf6+vTWuiHqzBiaJvUC6jl2IOhAi2aeHNW2UiNgmIoM52axw7F74jJPcBgnlnQ
JngVDCu8nkDIerW1JXexu1Z0neGhyE09tOuzo83tBYqJEVvVXxc50+cbmnDPnYnm
xy7wZAiv1xw=
=qeYI
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

