Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWGEH2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWGEH2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWGEH2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:28:04 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:22772 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932176AbWGEH2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:28:03 -0400
Message-ID: <44AB69FA.4090305@stesmi.com>
Date: Wed, 05 Jul 2006 09:27:54 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>,
       James Courtier-Dutton <James@superbug.co.uk>, perex@suse.cz
Subject: Re: OSS driver removal, 2nd round
References: <20060629192128.GE19712@stusta.de>	<200607010042.15765.ismail@pardus.org.tr>	<1151704572.32444.74.camel@mindpipe> <200607010249.05140.ismail@pardus.org.tr> <44A99C72.7070602@tmr.com>
In-Reply-To: <44A99C72.7070602@tmr.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig5A525288E0332CC8438170B1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A525288E0332CC8438170B1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bill Davidsen wrote:
> =C4=B0smail D=C3=B6nmez wrote:
>=20
>> Cumartesi 1 Temmuz 2006 00:56 tarihinde, Lee Revell =C5=9Funlar=C4=B1 =
yazm=C4=B1=C5=9Ft=C4=B1:
>>
>>> On Sat, 2006-07-01 at 00:42 +0300, =C4=B0smail D=C3=B6nmez wrote:
>>>
>>>> Cumartesi 1 Temmuz 2006 00:29 tarihinde =C5=9Funlar=C4=B1 yazm=C4=B1=
=C5=9Ft=C4=B1n=C4=B1z:
>>>>
>>>>> (I wish the authors of Skype, Flash, TeamSpeak, Enemy Territory, an=
d
>>>>> other proprietary OSS-only apps would understand this ;-)
>>>>
>>>> New skype beta supports Alsa, doesn't work ATM but its a great step =
in
>>>> that direction and Flash9 for Linux will use Alsa.
>>>
>>> Really?  Got a link?  Last I heard about Flash was that their lawyers=

>>> won't let them link to LGPL libraries which would rule out ALSA suppo=
rt.
>>
>>
>> Hear from the lead developer for Flash Linux :
>> http://blogs.adobe.com/penguin.swf/2006/06/week_in_review_1.html
>>
> Is that right? After years of negative comments about Flash and OSS, as=

> soon as it's converted to ALSA v1 api that going out in 2.6.18?
>=20

Actually I think you're mixing stuff up ?

It's being written for v4l v1 api which is being phased out with 2.6.18.

They already have alsa working (and from the sound of it it's working
great!).

v4l !=3D alsa. :)

// Stefan


--------------enig5A525288E0332CC8438170B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEq2oBBrn2kJu9P78RA62nAKCVk75FEB5yhKY6bnsv4BU9ZGNX3gCdFx4x
jYZUsCS+fT5pNH7MSk3ceQM=
=6s6r
-----END PGP SIGNATURE-----

--------------enig5A525288E0332CC8438170B1--
