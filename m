Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271041AbTGQSkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271551AbTGQSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:39:54 -0400
Received: from 200-55-45-150-tntats2.dial-up.net.ar ([200.55.45.150]:33666
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S271041AbTGQSh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:37:56 -0400
From: Norberto BENSA <nbensa@gmx.net>
Reply-To: nbensa@yahoo.com
Organization: BENSA.ar
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6 sound drivers?
Date: Thu, 17 Jul 2003 15:43:50 -0300
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030716225826.GP2412@rdlg.net> <200307171308.54518.nbensa@gmx.net> <s5hr84pytyi.wl@alsa2.suse.de>
In-Reply-To: <s5hr84pytyi.wl@alsa2.suse.de>
X-Operating-System: Gentoo GNU/Linux 1.4
X-PGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x49664BBE
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_p5uF/dIyvHwL6MT";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307171543.53110.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_p5uF/dIyvHwL6MT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Takashi Iwai wrote:
> the treble/bass code is implemented statically.
> (so it is also on OSS emu10k1 as default, btw.)
>
> note that there is an additional switch to activate bass/treble.
> as default, this is set off.  turn it on via alsamixer to get
> effects.

Ah, OK. Thank you. I'll take a look.


> > Anyone (Terje, Ed) care to say HOW did you enabled treble and bass in
> > emu10k1 (ALSA) or you will continuously say "it works for me" without
> > saying anything useful?
>
> hey, they told you right :)

Sorry. I didn't meant to be harsh but I haven't seen anything but "ALSA=20
supports emu10k1" or "emu10k1 is very well supported under ALSA." I just=20
wanted to know how to get tone control under ALSA and no one seems to share=
=20
that information. Or perhaps I miss a couple of e-mails from this list? I=20
can't find this one for example:

	Message-Id: <200307170107.03793.nbensa@gmx.net>

Seems like LKML swallowed that one. If that's the case, and I missed someon=
e's=20
reply, please forgive me.

Best regards,
Norberto


--Boundary-02=_p5uF/dIyvHwL6MT
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Fu5pFXVF50lmS74RAtbTAJ4t3Jq1hBhml0nDqhqjaCQt66A4YwCeNOWo
jt7V+J1BbKBPetFrhmRm8bk=
=9d7r
-----END PGP SIGNATURE-----

--Boundary-02=_p5uF/dIyvHwL6MT--

