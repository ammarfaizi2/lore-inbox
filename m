Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTEBPfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTEBPe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:34:59 -0400
Received: from dialpool-210-214-82-88.maa.sify.net ([210.214.82.88]:53377 "EHLO
	softhome.net") by vger.kernel.org with ESMTP id S262945AbTEBPe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:34:58 -0400
Date: Fri, 2 May 2003 21:16:29 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Anders Karlsson <anders@trudheim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Centrino
Message-ID: <20030502154629.GA2416@localhost.localdomain>
References: <1051851208.2846.84.camel@marx> <20030502085720.GA629@localhost.localdomain> <1051889480.3331.40.camel@marx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1051889480.3331.40.camel@marx>
X-GPG-Fingerprint: A977 433E B71E 2D1C 6114  9F33 F390 527D 70D1 2799
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2003 at 04:31:21PM +0100, Anders Karlsson wrote:
> On Fri, 2003-05-02 at 09:57, Balram Adlakha wrote:
> [snip]
> >=20
> > You mean the video card doesn't work properly? What happens when you ru=
n X etc?
> > Are you have trouble booting your centrino notebook or something?
> > The video card has got nothing to do with the cpu. Your centrino=20
> > notebook should work normally. If you want to save power then you can=
=20
> > select the power saving options in the config.
>=20
> Well, the vided card does work, but seemingly not after you restart your
> X server. You get presented with a black screen after restarting X, and
> you can kill the X server from there, so it runs, just doesn't show
> anything.
>=20
> The thinkpad boots, that is no problem. The powersaving has been brought
> to my attention as a possible source of problem. I already run it w/o
> ACPI, and will try disabling APM as well..
>=20
> The other thing that has been highlighted to me is that there might be a
> problem with idle in the 2.4.20 kernel. I will be trying 2.4.21-rc1 over
> the weekend if that works better.
>=20
> Regards,
>=20
> --=20
> Anders Karlsson <anders@trudheim.com>
> Trudheim Technology Limited

I think support for your video card was added in xfree 4.3. What=20
version are you running now?

--=20

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+spLV85BSfXDRJ5kRAji3AJ9Qh/6vW3hLIOaPS8k8YFBTMVbwDQCfcmFx
ZvJf/Cle413k71/sple/7ok=
=9EJU
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
