Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbUKKXI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbUKKXI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKKXGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:06:40 -0500
Received: from sukke.il.fontys.nl ([145.85.127.72]:48395 "EHLO
	sukke.il.fontys.nl") by vger.kernel.org with ESMTP id S262413AbUKKXFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:05:10 -0500
Date: Fri, 12 Nov 2004 00:05:09 +0100
To: Chris Wright <chrisw@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a.out issue
Message-ID: <20041111230509.GA9494@il.fontys.nl>
References: <20041111220906.GA1670@dereference.de> <20041111143258.Q14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20041111143258.Q14339@build.pdx.osdl.net>
X-Message-Flag: Please upgrade your mailreader to Mozilla Thunderbird at http://www.mozilla.org/
User-Agent: Mutt/1.5.6+20040722i
From: ed@il.fontys.nl (Ed Schouten)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 11 Nov 2004 02:32 PM, Chris Wright wrote:
> No oops here.  What kernel version?  Can you post your oops?

Just rebooted the box because it was dying slowly :D

Have you set:

sysctl -w vm.overcommit_memory=3D1

?

Yours,
--=20
 Ed Schouten <ed@il.fontys.nl>
 Website: http://g-rave.nl/
 GPG key: finger ed@il.fontys.nl

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBk/Alyx16ydahrz4RAoPIAKCiy7NEdYadR5OEZADUk2RWcQNJXwCcD7zR
g3SSdjuGYj4mFEIzcAj4pyo=
=JeVF
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
