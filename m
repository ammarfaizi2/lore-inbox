Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbTLZU1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTLZU1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:27:06 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:19338
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265271AbTLZU1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:27:02 -0500
Date: Fri, 26 Dec 2003 12:27:00 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
Message-ID: <20031226202700.GD12871@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031226081535.GB12871@triplehelix.org> <20031226103427.GB11127@ucw.cz> <20031226194457.GC12871@triplehelix.org> <3FEC91FA.1050705@rackable.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <3FEC91FA.1050705@rackable.com>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2003 at 11:54:34AM -0800, Samuel Flory wrote:
>   What does fuser -kv /mnt/cdrom claim?

It's /cdrom here. I tried it on both /cdrom and /dev/cdrom after
unmounting it, and the output was blank.

While mounted, here was the output:

                     USER        PID ACCESS COMMAND
/cdrom               root     kernel mount  /cdrom
No automatic removal. Please use  umount /cdrom

I guess that doesn't say much though...

--=20
Joshua Kwan

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+yZkqOILr94RG8mAQKiDBAA0GDJjazUqKzdCddRhFLvH1yEDVt64wYg
rmxK/yPPqLudgrgiPceL876G0rI9lFvJQoE3xXD3XLmVFzIH7PTEgHT4Ibo5ZK5T
whC8k7wVnabzJdKWB8olsEYx3GycUjfER/g344vOjto4qV+djpy/zTvYY3HLUaIH
mGIMVsyoGYAo2LVrMipT4N+6QW+gRChkReJtCabHkSxOgIPnqVkAQe1py2cqi/SO
d6UkUMmEDGbRZgR8ufcOKyN9O9Mi5EFqbwd5frkSZMi1M/Y7NySPV5tejIPpIkSm
cfecSr69bCVFGIZJCFsnU9yEiPb283n2XoP5tuM2ukvaO5qUATrgcoEHOVa2wqbM
nylJysiVAgZwuKMSqMvAU8kfETr0InBmhTehqFqSb2LbIzFS5kyRILT71ygeB4xc
bfIpmL2LJi+V8uw9ePqmcOMebHlzQJuU91YhHnJJGOkw1QEvnOB6bXcWO9T3CC6m
cjQF7YcSTQbb8QI0SldGGSOVOev9f5SyKZDDGjKFbhSm786gVAEfLyfQvrlIqPfO
U6Yw1K3ZDRKxGBNN69TGQz9cotzY1gPkfJHfSZ3kUcY9ILepuwQKetCDxKRAodmc
0nbjCo4NDfgFxqKmuUtgXrVRChpFbCPOmoWkBVRye/JNMF9Y498dRyjr+xY7hYu3
XOByxY1RQ08=
=z0Qx
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
