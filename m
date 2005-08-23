Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVHWACz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVHWACz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVHWACz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:02:55 -0400
Received: from hostmaster.org ([212.186.110.32]:2240 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S1750908AbVHWACz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:02:55 -0400
Subject: Surround via SPDIF with ALSA/emu10k1?
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LpdddGJq3VmG8Gr61YnH"
Date: Tue, 23 Aug 2005 02:02:53 +0200
Message-Id: <1124755373.5763.4.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LpdddGJq3VmG8Gr61YnH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am desperately trying to get surround sound working here. I have
- Creative Labs SB Live! 5.1 (emu10k1) card
- digital/SPDIF/coaxial connection
- Cambridge SoundWorks DTT2500
- linux-2.6.12.5
- alsa-lib-1.0.9rf-2

Digital and analog sound basically works. I can play music on the front
speakers or headphone and I can even play DVDs in DolbyDigital 5.1 with
ac3 passthrough.

Unfortunately I could not even get the rear/center/LFE connectors of my
card to work until I discovered the following page:
http://alsa.opensrc.org/index.php?page=3Demu10k1

Now I can either enable the 'SB Live Analog/Digital Output Jack' switch
and use the SPDIF connector to my DD5.1 surround system OR mute this
control and access/unmute the rear/center/LFE channels. Using analog
cabling is not an option as the DTT2500 has no connector for the
center/LFE channels.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

lotus notes: it's not just a mail program,
it's a complete denial of service attack in one box!




--=-LpdddGJq3VmG8Gr61YnH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQwpnrWD1OYqW/8uJAQJTZAf+PnfBlV6o8DfPIWllkpN1LXpUq3CzTnGe
ZjO2E3XJhskWVnHGr5YgoHh/FPdoI8eoOqeT8ahEEBIeV4SoHy4cNX6LQ2AXE3yM
qoX8xeWO6mPxc83eMEaWqLXpqqk/xVClJYQmBhIh8vHReofYlnssmRLmZ9IKN8eP
75fcCpglFcRkv5wwRxVDXayelGA2abofH6H5TE+o37rBkx5300pk35PUGGGOmzur
LvC2fohziG07zHMWZQe6ZF041c6gLtjIW5kLSkRJOeU2sxTZPkGmfou8n3iIJrPi
OSZJ/4Uj3zZklzsx3iELUDQ9lPY3Nd/2yDPZUkG5t5wVTbeOo20kKA==
=HC7y
-----END PGP SIGNATURE-----

--=-LpdddGJq3VmG8Gr61YnH--

