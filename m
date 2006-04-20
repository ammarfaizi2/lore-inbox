Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWDTUiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWDTUiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDTUiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:38:05 -0400
Received: from mail.goelsen.net ([195.202.170.130]:46245 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP
	id S1751211AbWDTUiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:38:03 -0400
From: Michael Monnerie <michael.monnerie@it-management.at>
Organization: it-management http://it-management.at
To: linux-kernel@vger.kernel.org
Subject: rtc: lost some interrupts at 256Hz
Date: Thu, 20 Apr 2006 22:37:33 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2229707.sE4QkKJAGk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604202237.34134@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2229707.sE4QkKJAGk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When you google for such messages, you can find a lot of people asking,=20
but nobody seems to have an answer. That's why I ask this list, where=20
the Godfathers Of Linux reside, and maybe someone hears my prayer and=20
could explain us sheep what you should do in such a case. Increase the=20
HZ from 250 to 1000, or decrease to 100? Or maybe setting the=20
preemption model from server to voluntary or preemptible? Or is that=20
whining to be ignored, and if yes, what is this message for at all?

Please give us wisdom, and we will spread your word. Amen.

Answers please per PM, I'm not on this list.

mfg zmi *or could you ask in a nicer way?*
=2D-=20
// Michael Monnerie, Ing.BSc    -----      http://it-management.at
// Tel: 0660/4156531                          .network.your.ideas.
// PGP Key:   "lynx -source http://zmi.at/zmi3.asc | gpg --import"
// Fingerprint: 44A3 C1EC B71E C71A B4C2  9AA6 C818 847C 55CB A4EE
// Keyserver: www.keyserver.net                 Key-ID: 0x55CBA4EE

--nextPart2229707.sE4QkKJAGk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBER/EOyBiEfFXLpO4RAiRWAJ9sUqefXDtyvtOhG27mwtby2ol7yACePpGU
EirLtmJkzOqmXrJtWRc7Qd8=
=7HWp
-----END PGP SIGNATURE-----

--nextPart2229707.sE4QkKJAGk--
