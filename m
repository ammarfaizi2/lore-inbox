Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJCPUX>; Wed, 3 Oct 2001 11:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRJCPUG>; Wed, 3 Oct 2001 11:20:06 -0400
Received: from 1-196.ctame701-5.telepar.net.br ([200.181.178.196]:58118 "EHLO
	stratus.heavenlabs") by vger.kernel.org with ESMTP
	id <S276369AbRJCPTv>; Wed, 3 Oct 2001 11:19:51 -0400
Date: Wed, 3 Oct 2001 12:29:44 -0300
From: sergio@bruder.net
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: CONFIG_SOUND_VIA82CXXX problems
Message-ID: <20011003122944.C8214@bruder.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm having some strange problems with VIA82CXXX sound driver.
(BTW, I'm using a ECS K7VZA - KT133A + VIA686b)

Sometimes my sound gets 'garbled', normally in the same time of a large video
update. Then I just cause more updates (just keep switching workspaces in
WMaker) and the sound 'corrects' itself again.

I'm using XMMS through artsd, if it matters. I already tried the kernel's
driver and the 1.1.15 version, too. I'm using 2.4.9-ac18.

BTW, I'm using an old S3 Trio64V+ 2MB PCI (Diamond Stealth Video 2001 Series).

Anyone with the same problem?

It's the sound driver, its the PCI bus, it's my video board or what?


Sergio Bruder
--
http://pontobr.org, http://sergio.bruder.net, http://bruder.homeip.net:81
-----------------------------------------------------------------------------
pub  1024D/0C7D9F49 2000-05-26 Sergio Devojno Bruder <sergio@bruder.net>
     Key fingerprint = 983F DBDF FB53 FE55 87DF  71CA 6B01 5E44 0C7D 9F49
sub  1024g/138DF93D 2000-05-26

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7uy7oawFeRAx9n0kRApryAJ46QRFzoSdbPW62psv7tAi13YGQAACghUtr
GtrhvO5NmgBNOfjPv7VFEKY=
=nG2s
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
