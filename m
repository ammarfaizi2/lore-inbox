Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWAJC3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWAJC3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWAJC3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:29:25 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:23208 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932272AbWAJC3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:29:24 -0500
Message-ID: <43C31BFD.5040401@stesmi.com>
Date: Tue, 10 Jan 2006 03:29:17 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de>	 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>	 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>	 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>	 <s5hmziaird8.wl%tiwai@suse.de>	 <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi>	 <1136504460.847.91.camel@mindpipe>	 <4A284096-E889-4E6D-B017-B8241CD72A0D@dalecki.de>	 <1136510509.9382.24.camel@localhost> <43BE8A04.6080603@stesmi.com> <5a2cf1f60601091555r4f9d9c58ie10d821342e8461b@mail.gmail.com>
In-Reply-To: <5a2cf1f60601091555r4f9d9c58ie10d821342e8461b@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig4BDD851F5E95F742E83587C8"
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BDD851F5E95F742E83587C8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi.

>>Same as when Renault introduced the keyless system in the Laguna in 2001
>>(some call it the Laguna II) - it's basically a card you stick into a
>>slot in the console which enables you to just press a button to start
>>the car instead of turning a key and it also contained memory about
>>your chair settings, mirrors and volume/sound settings of the radio.
>>
>>Now, is this a highly complex piece of software running there to do
>>those things?
>>
>>Regardless of how what someone believes - a few months later someone
>>was out driving and all of a sudden the car started speeding up and
>>since there was no key you couldn't turn the car off and the breaks
>>weren't strong enough to slow the car down and running at roughly
>>200kph he managed to YANK the card out of the slot before it could be
>>slowed down and the ignition turned off - the guy was lucky to be
>>alive.
> 
> 
> I think you are mixing 2 stories. According to my sources, the driver
> of a Renault Vel Satis reported a similar issue and got stuck at
> around 190kmph during an hour in October 2004. In March 2005, the
> driver of a Laguna reported that he got stuck at 90 kmph for 40km.

Hm.

>>It turns out that it was a combination of a bug in the keyless
>>system AND the cruise control that made this happen - two bugs
>>that in themselves wouldn't have triggered but at the right speed,
>>and when everything matched things went haywire, so no, no matter
>>how tight you write specifications or papers you can't get
>>everything bugfree, even in such a simple system as a keycard
>>for your car. Note that one of the bugs WAS in the keycard.
> 
> 
> To my knowledge, none of the reported issues have yet been identified
> as coming from the car. I searched again before posting and found no
> reference to that issue.
> 
> I would be happy to know where you found this information. At least to
> know if the constructors are hidding something.

Timeframe of the Laguna incident is roughly correct to my memory. It
was reported in the Swedish newspapers. I'll try searching for it
and see what I come up with, even though it's totally OT.

// Stefan

--------------enig4BDD851F5E95F742E83587C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDwxwBBrn2kJu9P78RA1trAKC4uikPcBibqisboHU6KpuwypUjNgCgn39/
/31hbTI13PvgaMGAyd0SJn0=
=Irs8
-----END PGP SIGNATURE-----

--------------enig4BDD851F5E95F742E83587C8--
