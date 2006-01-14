Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWANRkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWANRkH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWANRkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:40:07 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:48059 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750713AbWANRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:40:05 -0500
Message-ID: <43C93760.7040502@t-online.de>
Date: Sat, 14 Jan 2006 18:39:44 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nerijus Baliunas <nerijus@users.sourceforge.net>,
       Reuben Farrelly <reuben-lkml@reub.net>, dsd@gentoo.org
Subject: Re: why sk98lin driver is not up-to date ?
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5> <200601120339.17071.chase.venters@clientec.com> <43C63361.103@reub.net> <20060112181844.D8EF9BAE5@mx.dtiltas.lt> <43C7C03B.7000305@gentoo.org>
In-Reply-To: <43C7C03B.7000305@gentoo.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1C82BCEC344ADCBB65E43BB4"
X-ID: EwmQOqZTZe1zE6w1bRR9GXmaKAGmhJXSbdF4bs3kETqRTOnPjQE+sP
X-TOI-MSGID: 3b63a395-0c6c-438a-b28b-71ca88b707d8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C82BCEC344ADCBB65E43BB4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Daniel Drake wrote:
> Nerijus Baliunas wrote:
> 
>> Which one is better and what is a difference between them? Which one
>> will support Marvell Technology Group Ltd. 88E8050 Gigabit Ethernet
>> Controller
>> (rev 17)? skge in 2.6.14 does not support it.
> 
> 
> skge supports Yukon
> sky2 supports Yukon-2
> 
> 88E8050 is Yukon-2.
> 

Probably you need some testers for sky2. The -mm kernel would be a
little bit too experimental for me, but it seems to be in -git10.
Does this mean that it might appear in 2.6.15.1, or do I have to
wait for 2.6.16?


Regards

Harri

--------------enig1C82BCEC344ADCBB65E43BB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDyTdmUTlbRTxpHjcRAsXbAJ96egR7QIwju2sx+g7/zE54ZP6lXACeLV0D
c+rw2WLAgOEPb9D+FGGYf20=
=ZfNc
-----END PGP SIGNATURE-----

--------------enig1C82BCEC344ADCBB65E43BB4--
