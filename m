Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTI3XhB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTI3XhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:37:01 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:7392
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S261791AbTI3Xg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:36:56 -0400
Date: Tue, 30 Sep 2003 16:36:54 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: perex@suse.cz
Subject: Re: [ALSA PATCH] OSS emulation fixes
Message-ID: <20030930233654.GC10262@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
References: <Pine.LNX.4.53.0309301247030.1362@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309301247030.1362@pnote.perex-int.cz>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaroslav,

On Tue, Sep 30, 2003 at 12:51:52PM +0200, Jaroslav Kysela wrote:
> The pull command will update the following files:
>=20
>  include/sound/pcm_oss.h      |    1
>  include/sound/rawmidi.h      |    1
=2E..

In 2.6.0-test6-mm1 with OSS emulation I encountered a problem where xine
would use the sound card in OSS mode and no other application would be
able to use it after that until I rebooted. Do any of these fixes
address this problem?

By the way - something you folks did during -test5 improved the quality
of snd-intel8x0 by leaps and bounds. It used to crackle a lot at certain
frequencies and works great now. :)

Thanks,
--=20
Joshua Kwan

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP3oTlaOILr94RG8mAQJqoQ/+NU6pS8EaxmdIA2Uz+ubY4UGJ+9yOI48p
/32mW9ubQ9SU6CsspJy07Tb03ENdsPUD/kgSIutwqzPvhONk4QQnkFx9kOzEMevL
atomsfCsfI/7wALNHSSutyIG1Zb0LMb838sGfi3MOCkyU2ILLgkiGM7md5wYpJfl
JNHkcgwTqSMgg3hzxtDf09aWLu4hMi7iqG/JOLJFfVKTgQhtVU7N4yq4UHvs+6g9
X4N9ajScosWOQhCYrvms0ehVZObuF90VIaycrvVFiNJQmNo1C9x273XHBGshkJzX
A9biz08O3oItwe4JNj5NkzFOefOz0QhO75CQCOe0vWUgHpZG1rBJFlcjiIXX4COP
ZPtS2jExyGXczD+rhRPiZ+WfONwzmZrhDMosuLY81CUickmexd0YbEiL53SegIly
FyuuijzjwNXo0Y8pmbHarlr1S1x6XmCFDV/SPWFTcHEyaF/W7uTdPUarwDOhqTtu
By1nJB5VUlQ/6u1u/cEP3fx8FYJmCv7P/oVz0Q639rKfMok/y1HbMVmpCxgxd9Ei
xA3joSbO60fsCHsWzHyfEva2dr+BGnMU3nEAH2VAeamozBEPttR569+X4Uhk2SXR
dCTrRBJN2Hxg90UUKpJbXQnwBoOOLVVeuemtuBCc1UuqvItyircsIVazJ4h14Peb
17S5iiXxcNM=
=rBEE
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
