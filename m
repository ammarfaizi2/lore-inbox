Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVCVDpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVCVDpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVCVDoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:44:37 -0500
Received: from downeast.net ([204.176.212.2]:37329 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S262354AbVCVDlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:41:37 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Mon, 21 Mar 2005 22:41:20 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200503211958.54094.pmcfarland@downeast.net> <200503212215.58544.dtor_core@ameritech.net>
In-Reply-To: <200503212215.58544.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1968120.Joekgi7bq2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503212241.26780.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1968120.Joekgi7bq2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 21 March 2005 10:15 pm, Dmitry Torokhov wrote:
> Looks good, I was wondering if you had GAMEPORT=3Dm and SND_ENS1371=3Dy.

Yes, that would be quite silly. ;)

> > For the curious, what was the first kernel to be released that had your
> > sysfs stuff in it?
>
> 2.6.11-mm and 2.6.12-rc1. Vanilla 2.6.11 does not have it.

I'll go compile 2.6.11 to see if it works there.

> Could you verify that you enabled joystick port on card? What does
> "cat /sys/module/snd_ens1371/parameters/joystick_port" show?

0,0,0,0,0,0,0,0

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1968120.Joekgi7bq2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCP5Pm8Gvouk7G1cURAsNWAJ42MujJnayQM4dKJ9ai+tZzckI4AQCffLgt
c3znShjFcYlxYy0+zpZZYCU=
=UFCF
-----END PGP SIGNATURE-----

--nextPart1968120.Joekgi7bq2--
