Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270776AbRHNUIX>; Tue, 14 Aug 2001 16:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270784AbRHNUIN>; Tue, 14 Aug 2001 16:08:13 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:38416 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S270776AbRHNUIF>;
	Tue, 14 Aug 2001 16:08:05 -0400
Date: Tue, 14 Aug 2001 16:08:12 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: apm, swsuspend.
Message-ID: <20010814160812.I29740@jukie.net>
Mail-Followup-To: Bart Trojanowski <bart@jukie.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just purchased an HP Pavilion and was disappointed (but not surprised) to
find out that the suspend button is software driven (at least somewhat).
Needless to say it works great under the OS shipped with the laptop.

I played with apm but it keeps on dying with a APM_FUNC_SET_STATE APM
command not succeeding.  The apm_bios_call_simple fails with an error
stored in EAX of 0x6007; from what I can gether the error code is 0x60.

I would like to get the APM working well on this box.  Can anyone point
me to the APM specs, a better forum for this discussion, or a good
solution.

In the intrem... I have run across many mentions of a 'swsuspend' patch.
Where can I find this patch?

Regards,
Bart.

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7eYUskmD5p7UxHJcRAhCeAJ9l2Ep7olwjHgY4jHRfDBc26WdeewCcCgKV
P1SEgxtPepbeZPSC2r6B6E0=
=fewI
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
