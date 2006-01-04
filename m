Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWADJtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWADJtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWADJtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:49:10 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:19383 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1030202AbWADJtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:49:08 -0500
Message-ID: <43BB9A0B.3010209@stesmi.com>
Date: Wed, 04 Jan 2006 10:48:59 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl> <43BB16C0.3080308@stesmi.com> <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enigB3AE9567E1FF9CF06A86C72E"
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3AE9567E1FF9CF06A86C72E
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Tomasz K=B3oczko wrote:
> On Wed, 4 Jan 2006, Stefan Smietanowski wrote:
> [..]
>=20
>>> Solaris, AIX ..
>>> Full list is avalaible in "Operating System" listbox on
>>> http://www.4front-tech.com/download.cgi
>>
>>
>> Are all those Operatings Systems that include OSS per default, no
>> additional download required? Because that's what he's asking for,
>> not what you can get OSS for.
>>
>> Since that link is a _download page_ it makes me think that it's
>> an _additional download_ to get OSS support on those (or some of
>> those) operating systems.
>=20
>=20
> So start another "it makes me think" and imagine that in Solaris case
> using drivers not provided directly on distribution level is NORMAL
> habit. Why ? Bacause Solaris have well defined kernel API (from many
> years in some common areas it is constants which makes
> Documentation/stable_api_nonsense.txt from Linux tree piece of crap).
> This allow use device drivers prepared first for example for older
> kernels (8,9) on latest (10). I.e.: Solaris 10 inroduces stop supportin=
g
> some older network cards (IIRC for old SMC cards). I know people which
> still uses this cards on Sol10 by using binary drivers prepared for
> older Solarises without visable problems. Also many device drivers have=

> double versions (one from distribution resouurces and second provided b=
y
> device vendor).
>=20
> Summarize: stop looking on sound subsystem problems as Linux specyfic
> and assume that THE SAME problems exists on other unices in so simillar=

> form
> so is possible thinking on OSS support on kernel level details in the
> same forms as on other unices. Linux case isn't so unusual in this area=

> .. it is VERY typical :>
> If you will take this as true you can start looking on OSS API on Linux=

> from correct point of view.
> And start asking ALSA people: why using OSS API in other unices simple
> works and it ins't problem and on Linux "it was so big problem that
> reinventing sound support in ALSA form was neccessary" ?
>=20
> kloczek

So if I buy $COMMERCIAL_PROGRAM for say Solaris, AIX or anything else
it REQUIRES me to download (before: buy) $COMMERCIAL_SOUNDSYSTEM?

"In order to use this program you need to have OSS installed."

That sounds insane to say the least.

// Stefan

download $COMMERCIAL_SOUNDSYSTEM ins


--------------enigB3AE9567E1FF9CF06A86C72E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDu5oPBrn2kJu9P78RA0f8AJ45WPcjZMbQdrhJmkYFuhgVvOQmtwCeN8zQ
xb+DmfKBUY/kjI3lvqceCtY=
=Pq+J
-----END PGP SIGNATURE-----

--------------enigB3AE9567E1FF9CF06A86C72E--
