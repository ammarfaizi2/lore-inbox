Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbRGPSDh>; Mon, 16 Jul 2001 14:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbRGPSD3>; Mon, 16 Jul 2001 14:03:29 -0400
Received: from a9163.upc-a.chello.nl ([62.163.9.163]:10039 "EHLO
	casa.casa-etp.nl") by vger.kernel.org with ESMTP id <S267473AbRGPSDF>;
	Mon, 16 Jul 2001 14:03:05 -0400
Date: Mon, 16 Jul 2001 19:13:53 +0200
From: Kurt Garloff <garloff@suse.de>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: /proc/sys/kernel/hz
Message-ID: <20010716191353.G16948@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ulrich Drepper <drepper@cygnus.com>,
	Linux kernel list <linux-kernel@vger.rutgers.edu>
In-Reply-To: <938F7F15145BD311AECE00508B7152DB034C48DA@vts007.vertis.nl> <m38zhorf6s.fsf@otr.mynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m38zhorf6s.fsf@otr.mynet>; from drepper@redhat.com on Mon, Jul 16, 2001 at 09:50:35AM -0700
X-Operating-System: Linux 2.4.3-p7-amp-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2001 at 09:50:35AM -0700, Ulrich Drepper wrote:
>=20
>   hz =3D sysconf (_SC_CLK_TCK);
>=20
> Update your libc and this info will come from the kernel.

Suppose HZ is variable. How does glibc find out about HZ of the _running_
kernel? Just curious ... as I don't see a public place where the kernel
publishes such info.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7UyDQxmLh6hyYd04RAnPXAJ4h+TMPAh90IdZ9Wyp8hahRgJ8h+QCgqvMt
9nTAecuzj39fbfJXon4VWFA=
=QHP5
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--

