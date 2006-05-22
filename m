Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWEVCFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWEVCFv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 22:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWEVCFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 22:05:51 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:17299 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932413AbWEVCFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 22:05:50 -0400
Message-ID: <44711C79.6090004@stesmi.com>
Date: Mon, 22 May 2006 04:05:45 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <Pine.LNX.4.61.0605212026570.6083@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605211528010.25580@p34>
In-Reply-To: <Pine.LNX.4.64.0605211528010.25580@p34>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enigA3770CF9894ECA9624CC4185"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3770CF9894ECA9624CC4185
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Justin Piszcz wrote:
> Compressed with -9.
> 
>      -9            slowest (best) compression
> 
> Unsure on the maximum distance.
> 
> Version info:
> 
> rzip 2.1
> Copright (C) Andrew Tridgell 1998-2003
> 
> 
> On Sun, 21 May 2006, Jan Engelhardt wrote:
> 
>>>
>>> Was curious as to which utilities would offer the best compression
>>> ratio for
>>> the kernel source, I thought it'd be bzip2 or rar but lzma wins,
>>> roughly 6 MiB
>>> smaller than bzip2.
>>>
>> You forgot:
>>  - .7z    7zip
>>  - .j     JAR (www.arjsoftware.com)
>>  - .ice   LHICE (some sort of "brother" to lharc aka lzh)
>>  - .ace   ACE (www.winace.com)
>>  -        UPX (yes!, you just need to put '#!/\n' at the front)
>>  - .cab   MS CAB (use winace)
>>  - .bh    BlackHole
>>  - .pak   PKARC 2.51
>>  - .sqz   SqueezeIt
>>  - "LZEXE"
>>
>> ftp://camelot.spsl.nsc.ru/pub/win32/arc/ - you'll find some there
>> happy packing :)
>>
>>> 38064   linux-2.6.16.17.tar.rz
>>
>>
>>  - is this rzip with _maximum_ distance?
>>
>>
>> Jan Engelhardt

Don't forget about .lzx! Probably need an amiga to use it though :)

BUT I could be remembering wrong but I think that they use a newer
version of lzx compression in .CAB since that guy got a job at MS
back in the days.

// Stefan

--------------enigA3770CF9894ECA9624CC4185
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEcRx8Brn2kJu9P78RA05UAKDHZcsL6Hbk2V7srrCn+xk1R0O6ogCfRf+j
uxoI8A1C4sQ31IIKeA1pjeM=
=3/ec
-----END PGP SIGNATURE-----

--------------enigA3770CF9894ECA9624CC4185--
