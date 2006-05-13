Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWEMAUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWEMAUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEMAUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:20:36 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:50121 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932224AbWEMAUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 20:20:34 -0400
Message-ID: <4465264D.6050608@stesmi.com>
Date: Sat, 13 May 2006 02:20:29 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com> <446505F8.7020909@gmail.com>
In-Reply-To: <446505F8.7020909@gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig99880D32CE1408EF418A3B78"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99880D32CE1408EF418A3B78
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Stefan Smietanowski wrote:
> 
>> Randy.Dunlap wrote:
>>
>>>> * New error handling
>>>> * IRQ driven PIO (from Albert Lee)
>>>> * SATA NCQ support
>>>> * Hotplug support
>>>> * Port Multiplier support
>>>
>>>
>>> BTW, we often use PM to mean Power Management.
>>> Could we find a different acronym for Port Multiplier support,
>>> such as PMS or PX or PXS?
>>
>>
>> Ok, maybe not PMS ?
>>
>> Can you imagine a bug report from someone that "has problem with PMS"?
>> :)
>>
> 
> Would be fun though.  :)
> 
> I thought about using another acronym for port multiplier too.  But the
> spec uses that acronym all over the place, PM, PMP (Port Multiplier
> Portnumber), which reminds me of USB full/high speed fiasco.
> 
> Urghh... I thought we could use power for power management inside libata
> but that might be a bad idea.  So, PMS?

Actually, pmup?

Sort of describes what it is at the same time. (Alot easier to figure
out what pmup is than what pms is (in a computer :))

// Stefan

--------------enig99880D32CE1408EF418A3B78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEZSZQBrn2kJu9P78RA+cDAJ4ob4lUFb+voZAKhaMmnCapEweyxQCbBN80
q0Lhk+bDVNG4OhiscWX9BkE=
=MaWS
-----END PGP SIGNATURE-----

--------------enig99880D32CE1408EF418A3B78--
