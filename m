Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937563AbWLFTqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937563AbWLFTqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937566AbWLFTqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:46:32 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:5356 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937563AbWLFTqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:46:31 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <1165347242.8326.15.camel@localhost>
References: <1165153834.5499.40.camel@localhost.localdomain>
	 <1165259962.6152.5.camel@localhost.localdomain>
	 <1165261226.5499.54.camel@localhost.localdomain>
	 <1165263296.6152.8.camel@localhost.localdomain>
	 <1165304498.5499.62.camel@localhost.localdomain>
	 <1165347242.8326.15.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HcxZAC35ei1qp+fLXCl5"
Date: Wed, 06 Dec 2006 19:46:13 +0000
Message-Id: <1165434373.28197.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: PMTMR running too fast
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HcxZAC35ei1qp+fLXCl5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-05 at 11:34 -0800, john stultz wrote:
>=20
> > Should tsc be preferred to pit though?
>=20
> Depends on your system. If C2/C3 or cpufreq state changes are
> detected, we mark the tsc as unstable. =20

Turns out I was seeing C2 states. I'll stick with PIT for now.

Thanks,
Ian.

--=20
Ian Campbell

If ignorance is bliss, why aren't there more happy people?

--=-HcxZAC35ei1qp+fLXCl5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFdx4EM0+0qS9rzVkRAjuSAJ9sXYBCYtWhsYzp5Vvn6SMdQhTffwCfbTLV
3OJIJbhlaw38glcbECIo7qI=
=ZjUF
-----END PGP SIGNATURE-----

--=-HcxZAC35ei1qp+fLXCl5--

