Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVALMbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVALMbC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVALMbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:31:02 -0500
Received: from pop.gmx.de ([213.165.64.20]:10452 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261162AbVALMaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:30:55 -0500
X-Authenticated: #4512188
Message-ID: <41E51876.5020703@gmx.de>
Date: Wed, 12 Jan 2005 13:30:46 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050107)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: krishna <krishna.c@globaledgesoft.com>,
       lirc <lirc-list-request@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LIRC for Infra Red port.
References: <41E510C7.5060100@globaledgesoft.com> <Pine.LNX.4.61.0501121310010.14535@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0501121310010.14535@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE034F12BA9C44DF9F7382E0E"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE034F12BA9C44DF9F7382E0E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Engelhardt schrieb:
>>Hi all,
>>
>>  I am working on LIRC-serial.
>>
>>But in my main board I also have Infra Red Port. I don't want to use the serial
>>port so that it I can use for some other purpose.
>>Does any one know How could I use the IR port instead of Serial port.
>
>
> The BIOS has a switch to reserve COM2 (maybe others) for IR, hopefully.

Or in other words: You'll loose your serial port either way...

Prakash

--------------enigE034F12BA9C44DF9F7382E0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB5Rh8xU2n/+9+t5gRAo8VAJ41SzTm9tjDlR6wCGFgYQ4H48xtgACfW8Sj
mS3xHe0aB2rxOHWMCkJp6cw=
=km9O
-----END PGP SIGNATURE-----

--------------enigE034F12BA9C44DF9F7382E0E--
