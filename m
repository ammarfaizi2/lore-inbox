Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVLCWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVLCWgj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 17:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLCWgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 17:36:39 -0500
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:40789 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751294AbVLCWgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 17:36:39 -0500
Message-ID: <43921DEC.9080406@unsolicited.net>
Date: Sat, 03 Dec 2005 22:36:28 +0000
From: David Ranson <david@unsolicited.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <4391CEC7.30905@unsolicited.net> <1133630012.6724.7.camel@localhost.localdomain> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <4391E52D.6020702@unsolicited.net> <20051203222731.GC25722@merlin.emma.line.org>
In-Reply-To: <20051203222731.GC25722@merlin.emma.line.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig85E771F37F5360D029D3A203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85E771F37F5360D029D3A203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Matthias Andree wrote:

>So was I. And now what? ipfwadm and ipchains should have been removed
>from 2.6.0 if 2.6.0 was not to support these. That opportunity was
>missed, the removal wasn't made up for in 2.6.1, so the stuff has to
>stick until 2.8.0.
>
>
I'm not aware of that policy... maybe I overlooked something?

>This doesn't matter. A kernel that calls itself stable CAN NOT remove
>features unless they had been critically broken from the beginning. And
>this level of breakage is a moot point, so removal is not justified.
>
>

>Who cares what you or I use? It's a commonly acknowledged policy that
>"stable" releases do not remove features that are good enough for some.
>Linux 2.6 is not "stable" in this regard.
>
>
I guess our definitions of stable (and the degree of stability
acceptable) differ.

David



--------------enig85E771F37F5360D029D3A203
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFDkh30DYHcaCYtZo4RAvHBAKD0VzJnojZ+iup99MIh8zXwj2x4YgCfYCc1
rCXexbmooY4hFmNC8fq0tZU=
=VJnb
-----END PGP SIGNATURE-----

--------------enig85E771F37F5360D029D3A203--
