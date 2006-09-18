Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965541AbWIRIIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965541AbWIRIIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965539AbWIRIIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:08:18 -0400
Received: from systemlinux.org ([83.151.29.59]:21904 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S965541AbWIRIIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:08:17 -0400
Date: Mon, 18 Sep 2006 10:07:44 +0200
From: Andre Noll <maan@systemlinux.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] 2.6.18-rc5 page_to_pfn: Unable to handle kernel NULL	pointer dereference
Message-ID: <20060918080744.GC20462@skl-net.de>
References: <20060908073125.GA23642@skl-net.de> <20060915124043.GA20462@skl-net.de> <1158350827.5501.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <1158350827.5501.4.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16:07, Trond Myklebust wrote:

> Does the attached patch fix it?

Patch applied and rebooted with no problems so far. I'll let you know
if it oopses again.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFDlPQWto1QDEAkw8RApm6AKCajoLl/wtardDt4E9cBqT9ePKchQCeKvW/
yaLltvS/JL7LBLcud7MQRjg=
=erNu
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
