Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263068AbUKTBNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbUKTBNC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUKTBNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:13:01 -0500
Received: from 66.80-203-204.nextgentel.com ([80.203.204.66]:5282 "EHLO
	66.80-203-204.nextgentel.com") by vger.kernel.org with ESMTP
	id S263086AbUKTBKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:10:38 -0500
Message-ID: <419E997E.6000404@nidelven-it.no>
Date: Sat, 20 Nov 2004 02:10:22 +0100
From: "Morten W. Petersen" <morten@nidelven-it.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fixing page allocation failure
References: <419C8756.3080709@nidelven-it.no> <20041118180124.0e6bf05e.akpm@osdl.org>
In-Reply-To: <20041118180124.0e6bf05e.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4100433CFF85326790C91C49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4100433CFF85326790C91C49
Content-Type: multipart/mixed;
 boundary="------------090705080100050409030707"

This is a multi-part message in MIME format.
--------------090705080100050409030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> It should also emit a stack backtrace.   If so, please send it.

OK, I've attached the kern.log file, which should explain the setup and 
has some call traces.  The server has about 300-350 MBs of RAM, 500 MBs 
of swap, and typically uses about 2-300MBs of swap at any given time.

It's recorded load average is typically between 0.1 and 0.2, at times up 
to 1.0.

I've got some additional kern.log files if you're interested.

HTH,

Morten

PS:  I this is the second copy of this message, the first one I sent 
didn't come through.

--------------090705080100050409030707
Content-Type: application/gzip;
 name="kern.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kern.log.gz"

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
--------------090705080100050409030707--

--------------enig4100433CFF85326790C91C49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBnpmDbYZVKBu9STYRAho3AKCIuceMfb2dyTcF/Ri+k4IA8dRyMACg29ED
1Gv3HvQpO7NLd7WVqjygqsI=
=3hup
-----END PGP SIGNATURE-----

--------------enig4100433CFF85326790C91C49--
