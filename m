Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWBMMNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWBMMNb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWBMMNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:13:31 -0500
Received: from sipsolutions.net ([66.160.135.76]:2057 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932104AbWBMMNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:13:30 -0500
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel]
	Re: [ 00/10] [Suspend2] Modules support.)
From: Johannes Berg <johannes@sipsolutions.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Valdis.Kletnieks@vt.edu, suspend2-devel@lists.suspend2.net,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <451E960D-8FA5-474E-8C72-B8F834D03AF7@mac.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz>
	 <200602111136.56325.merka@highsphere.net>
	 <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com>
	 <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com> <43EF24C0.2040902@gmail.com>
	 <47B33C16-AEC3-4036-BA05-AE235014684E@mac.com>
	 <200602121656.k1CGurd7019092@turing-police.cc.vt.edu>
	 <451E960D-8FA5-474E-8C72-B8F834D03AF7@mac.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-09RExCjTrvfINdYOJi14"
Date: Mon, 13 Feb 2006 13:12:56 +0100
Message-Id: <1139832776.6388.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-09RExCjTrvfINdYOJi14
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-12 at 13:28 -0500, Kyle Moffett wrote:

> /me reads spec. *sigh*  Whatever idiocy-committee wrote that spec was =20
> clearly either smoking crack or living in a fantasy-world (or both).  =20
> An arbitrary unrestricted DMA bus is a massive and painfully obvious =20
> security hole.  Can somebody _please_ shoot the guy that came up with =20
> that brilliant idea?  At least it looks like it's not available if =20
> the firewire modules aren't loaded, which means that you can prevent =20
> that sort of attack, and my laptop luckily doesn't load those modules =20
> at boot just to save a bit of memory. =20

might not help since your firmware turns on the firewire port to enable
booting from firewire disks.

> Even still, that's just a =20
> terrible idea.  Is there any practical way to restrict DMA and make =20
> FireWire secure?

load the modules with phys_dma=3D0

johannes

--=-09RExCjTrvfINdYOJi14
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAQ/B3xqVg1VMiehFYAQI+gRAAu7TrBewbQs26TyEVEl1TuAIufv0uSpgS
JCOyUGDhZ4fzYsj7ArD6CXyVjWpDCCGMVRPqMxUvoRZyAgT5SL/oDW4vuzuF9xZH
U7CL/gxooxYFzMH8wMNG6cUUh4Ag6Oi/x9VQHYkoZ/jTTOx1z+fjqv31RylYjgrl
2mTmGmPvILRWcI2ESmcpNZ+mYbZYcreJFjuFKsVqV5504HBqRuSVt2U21An5ZW+U
SmJORufn5tCyt/m2veCMPphHidKjAcYSci/MG2AmCQpP7VoOIsemzXkhAxX5TN5b
Z9TaNd3+E7moiZRvb6mdjG0TtkegF+jyRp089TVnm3D9LnayYupkizAdszBlV12L
cMVTAwgJ4fI9VCuA1PNe1pVeOUqF5LKaRl3n2IWB0niMkeXdSQEIG++fv5hZh6YG
8X7dMVHxVzoxb5flzO91TnEhWzQJfJA1Mw+W1E38c4Dc+6Zj4kty7ncwodqUSd6L
oJ5YMhpe4mee3S/ynuaoh+4QBE9g12v5jcJ7oeDYa/AB8phC35UL8vplvAfUHEHo
ul00otgrICRzKaJlM+VcaC8ic59brUoRsYN0sRJea+xLwdFL7GgCtFeWov3P8DmV
2LvgKZpbMIP5COzIbDlqlS1pTiEGlo/ru6NEDa9DzCkTfHAOR9RCxN9wd3kv/AYG
sHzCUav3XFg=
=1hlF
-----END PGP SIGNATURE-----

--=-09RExCjTrvfINdYOJi14--

