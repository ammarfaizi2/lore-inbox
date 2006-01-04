Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWADA26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWADA26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWADA26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:28:58 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:63390 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S965012AbWADA24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:28:56 -0500
Message-ID: <43BB16C0.3080308@stesmi.com>
Date: Wed, 04 Jan 2006 01:28:48 +0100
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
References: <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig1F25B72B6293A27AFC6A6A12"
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F25B72B6293A27AFC6A6A12
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Tomasz K=B3oczko wrote:
> On Wed, 4 Jan 2006, Adrian Bunk wrote:
> [..]
>=20
>>>   OSS is universal cross-unix API. ALSA is Linux-only.
>>
>>
>> How "universal cross-unix" is the OSS API really?
>>
>> Which operating systems besides Linux have a native sound system
>> supporting the OSS API [1]?
>>
>> I know about FreeBSD and partial support in NetBSD.
>>
>> Are there any other [2]?
>=20
>=20
> Solaris, AIX ..
> Full list is avalaible in "Operating System" listbox on
> http://www.4front-tech.com/download.cgi

Are all those Operatings Systems that include OSS per default, no
additional download required? Because that's what he's asking for,
not what you can get OSS for.

Since that link is a _download page_ it makes me think that it's
an _additional download_ to get OSS support on those (or some of
those) operating systems.

// Stefan


--------------enig1F25B72B6293A27AFC6A6A12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDuxbDBrn2kJu9P78RAwE7AKCgTBbZkoLq4hWR3SUXAciDkiqKqACfdsYY
+0244RzwsL+xQbQtUbjm+Tg=
=AOSw
-----END PGP SIGNATURE-----

--------------enig1F25B72B6293A27AFC6A6A12--
