Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWDEJdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWDEJdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWDEJdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:33:37 -0400
Received: from mail.phnxsoft.com ([195.227.45.4]:23050 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1751190AbWDEJdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:33:37 -0400
Message-ID: <44338EDA.4020909@imap.cc>
Date: Wed, 05 Apr 2006 11:33:14 +0200
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, hjlipp@web.de, kkeil@suse.de
Subject: Re: + isdn4linux-siemens-gigaset-drivers-logging-usage.patch added
 to -mm tree
References: <200604040051.k340p0RI008205@shell0.pdx.osdl.net>	 <1144113590.3067.4.camel@laptopd505.fenrus.org>  <4432FABE.1000900@imap.cc> <1144199982.3047.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1144199982.3047.0.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE17E0AF18DF47C602C8F87E9"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE17E0AF18DF47C602C8F87E9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Arjan van de Ven wrote:

> On Wed, 2006-04-05 at 01:01 +0200, Tilman Schmidt wrote:
>> On 04.04.2006 03:19, Arjan van de Ven wrote:
>>
>> >>+	struct semaphore sem;		/* locks this structure:
>> [...]
>> >
>> > please consider turning this into a mutex
>>
>> Your wish is our command. Consider it already done. :-)
>
> great!
>
> apologies for missing that; that's what you get for trusting mail
> filters to trigger on patch fragments ;(

No trouble. Happens to the best of us.

Thanks for the time and effort you are putting into all this.
I appreciate it.

Regards
Tilman

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enigE17E0AF18DF47C602C8F87E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEM47aMdB4Whm86/kRAtoOAJwI/Pjj8xbQjE6WbUIK/MummAPaugCeLr+B
Lk/fTMdRwK+vqBXkZgoTMf4=
=dSE4
-----END PGP SIGNATURE-----

--------------enigE17E0AF18DF47C602C8F87E9--
