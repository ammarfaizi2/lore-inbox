Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTJ1H0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 02:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTJ1H0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 02:26:47 -0500
Received: from adsl-68-120-202-5.dsl.pltn13.pacbell.net ([68.120.202.5]:1504
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263869AbTJ1H0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 02:26:46 -0500
Date: Mon, 27 Oct 2003 23:26:45 -0800
To: linux-kernel@vger.kernel.org, lipeng@acm.org
Subject: Re: 512MB/1GB RAM & Wireless Card
Message-ID: <20031028072645.GB5795@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
	lipeng@acm.org
References: <20031028064554.GA20596@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20031028064554.GA20596@seas.upenn.edu>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2003 at 01:45:54AM -0500, Peng Li wrote:
> Problem: I installed an Dell Truemobile 1150 MINI PCI wireless card (a
> rebranded orinoco gold) on this machine and it didn't work.  The card
> worked perfectly in Windows, but when I use it in Linux, the PCMCIA
> driver could not find the device.

Always the same first question: was CONFIG_ISA enabled in your .config?
It's what I needed to do to get my Orinoco to work under Linux.

Interesting that it worked when you unplugged the RAM, but I don't see
an immediate correlation.

--=20
Joshua Kwan

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP54aM6OILr94RG8mAQJuGBAA9N06VPgC/rOagsDQ18lCINRmbl8TX+27
vQ7jIv3abA3f8DUB7M3I2DVMh54TXnvRne5JsC6ThjmQEMHDUD2rZm4WfrThqIDB
W7kUk4Aq+z0Tx8uab08Y+/LpkwIb7Mb9MJevIvoY7g/zMXA4QtaqaArXptgvmfyO
z8xt5gzdjGpsCHB1b9DxmXHw2SsMjaexFxGlInHtO1xtFdep7otsqhYpEoB+U5Ul
v65l9HZltjya7LqS339smuz9a2cvDO+Wp9Aeuo9GBfNvL/fgl2abd4+fau+5/Kmd
m19NhIRgZvnh+Or4AQPpH1xzM0eOLpYpgUyPYXX+j6llZANJJGkAhvgMF/TYHdtD
LFhlSa357XBrJrojfWvX24qfgqAnjXWQICgw82amXqzYT0HyFvtquXAoObsjgXYg
GF/nbL0CU63BkL7bZr+ctdsNws7A6Xje/WejQmSD6LEEPajy2Er1iqX5+oVk+d5/
j/grHox78N8qM6v9L4rmJQPUL2YyvXdUqhdLvwjWiyf/6HZKPj+p0+2hAM5mqusr
CzxFizps26OxVJdlhtfKU/TFOA2DKcPKMY2KznUQqVDA7AtqMDwHfAEWSxkAl0Gy
q7ChkJ6HNUZYLT2ATsKqaPm/LgQ3hpfpDX3MEqtPYSz6NHeKwF5+YQ3nKvwvRSN6
/XaNkw2XQew=
=veTC
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
