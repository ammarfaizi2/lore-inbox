Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbUBDTDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUBDTDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:03:17 -0500
Received: from b074202.adsl.hansenet.de ([62.109.74.202]:46213 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264137AbUBDTDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:03:12 -0500
Message-ID: <402141E9.7070204@portrix.net>
Date: Wed, 04 Feb 2004 20:03:05 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stefan.tell@crashmail.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Sensors with kernel 2.6.2
References: <87u126loxa.fsf@zeus.crashmail.de>
In-Reply-To: <87u126loxa.fsf@zeus.crashmail.de>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0C47D83C3209815CFD50773"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0C47D83C3209815CFD50773
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Stefan 'Steve' Tell wrote:
> Hi Folks,
> 
> I have some problems with my sensors.
> 
> In kernel 2.6.1 i received temperatures like 69,5°C CPU and 41°C
> mainboard. Since 2.6.2 I received 418,5°C CPU and 347,0°C
> mainboard. This error occured in 2.6.2rc3, too.

You have to update to latest userspace sensors cvs. (www.lm-sensors.nu)

Jan

--------------enigA0C47D83C3209815CFD50773
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAIUHpLqMJRclVKIYRAmNPAJ9DuHmTfkKy5avYbcRwh2UcwA6NVgCfTiU3
lV4vnqzkGJQdBBxOMZ4yAl4=
=hqs+
-----END PGP SIGNATURE-----

--------------enigA0C47D83C3209815CFD50773--
