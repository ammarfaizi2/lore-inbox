Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUAFRUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUAFRUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:20:50 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:19593 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S264537AbUAFRUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:20:48 -0500
Date: Tue, 6 Jan 2004 18:20:47 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: problem booting aic7xxx-old with reiserfs
Message-ID: <20040106172047.GA5080@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <2263062704.1073407695@aslan.scsiguy.com>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Justin <gibbs@scsiguy.com> wrote:
> This means that Domain Validation was unable to probe the your
> Quantum Fireball correctly.  For me to understand why, you need to
> compile the driver with debugging enabled and the debug mask set
> to 0x3F. Both of these settings can be performed via the standard
> kernel configuration tools.  Just boot with those settings and
> send me the complete boot output.  You may need to increase the
> size of your dmesg buffer for all of the output to be recorded.

Thanks, I will try that and let you know. Please keep me on this
thread CC as I can't read the list.

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
when compared to windoze, unix is an operating system.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+u5vIgvIgzMMSnURAqL2AJ40w0YQ40OL8/X+ySZjanzjBMxkqACff7yN
v023n/qDFUeXW6UIf5zib2w=
=dKXr
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
