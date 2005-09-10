Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVIJSb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVIJSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIJSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:31:29 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:24721 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932133AbVIJSb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:31:28 -0400
Message-ID: <43232660.5070504@t-online.de>
Date: Sat, 10 Sep 2005 20:30:56 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Gifford <maillist@jg555.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43228E4E.4050103@jg555.com> <p73k6hp2up7.fsf@verdi.suse.de> <43229BA4.4010306@pobox.com>
In-Reply-To: <43229BA4.4010306@pobox.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D8A3413F32F2A4D113E8D9F"
X-ID: VUNPhYZZweUYcXQ2xirLJHbmoY-evy0XNIry6rer5cV61wzx7jzEsV
X-TOI-MSGID: 8ad84b1a-5fdd-4ee7-b555-c3fd56748e6d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D8A3413F32F2A4D113E8D9F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Andi Kleen wrote:
> 
>> Jim Gifford <maillist@jg555.com> writes:
>>
>>
>>> I have been working on a project to create a Pure 64 bit distro of
>>> linux, nothing 32 bit in the system. I can accomplish that with no
>>
>>
>>
>> Hopefully you're using /lib64 for that, otherwise your
>> packages will be incompatible to everybody else and not FHS compliant.
>> If you don't please don't submit any patches to hardcode this to
>> upstream packages.
> 
> 
> /lib64 is an awful scheme.  I'd avoid it.
> 

Indeed. It just helps to keep unclean 32bit applications
alive.

Maybe you would like to check Debian for amd64? The 32bit
stuff is purely optional (except for the boot loaders, AFAIK).

http://www.debian.org/ports/amd64/


Regards

Harri

--------------enig2D8A3413F32F2A4D113E8D9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDIyZkUTlbRTxpHjcRAmYsAJ9FVluR2vbHNOH3DhFJ7+L27dCuCgCfRj3y
FKHig76Q65AxCOt7XI2yfDU=
=ePbq
-----END PGP SIGNATURE-----

--------------enig2D8A3413F32F2A4D113E8D9F--
