Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUAFIrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUAFIri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:47:38 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:59531 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261552AbUAFIrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:47:35 -0500
Date: Tue, 6 Jan 2004 09:47:28 +0100
From: martin f krafft <madduck@madduck.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem booting aic7xxx-old with reiserfs
Message-ID: <20040106084728.GA3094@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1aMb6-3Fs-37@gated-at.bofh.it> <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20040106084152.7B47D52003@chello062178157104.9.14.vie.surfer.at>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Andreas Theofilu <noreply@TheosSoft.net> [2004.01.06.0941 +0100=
]:
> The old aic7xxx driver seems to be broken. Whenever possible use
> the new AIC7xxx driver. It works perfect here.

I tried that, but at first, the driver spat out thousands of lines
of errors before the kernel failed to mount the root filesystem, and
then upon reboot, I still got various errors related to SCSI. When
I looked in the description of the aic7xxx drivers, I only found the
294x covered by the old driver.

I'll try again, I guess...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
microsoft windoze - the best solitaire game you can buy.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+nYgIgvIgzMMSnURAr0GAKDFdD0zx2CWaPc11Dc1S024hJBDUQCfQxQw
XnI4kTUkqLP6ynEKXGyRV9I=
=7oIA
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
