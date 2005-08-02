Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVHBFgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVHBFgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVHBFgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:36:04 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:42631 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S261234AbVHBFgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:36:02 -0400
Message-ID: <42EF0624.2080503@engr.orst.edu>
Date: Mon, 01 Aug 2005 22:35:32 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050728)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, tony@atomide.com, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [ck] [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
References: <200508021443.55429.kernel@kolivas.org>
In-Reply-To: <200508021443.55429.kernel@kolivas.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFEE7AB69A78FE5A0273AA27B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFEE7AB69A78FE5A0273AA27B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> My desktop pentium4 did not like the patch erroring with "bad gzip magic 
> number" on boot for reasons that aren't obvious to me. This could be related 
> to trying gcc 4.0.1 on that box whereas the laptop is on gcc 3.4.4 and is 
> working fine.
> 

Just writing to report that on my laptop with a pentium 4 m that it
boots just fine. No idea what the change in power use is at the moment.
Compiled using gcc 3.3.5.

-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enigFEE7AB69A78FE5A0273AA27B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC7wYpiP+LossGzjARAhQKAJ98lFUCS3Go15h4DmK4ubCYiwytlwCfYpsV
aYzLK7zTuAolDvHFQMthzIU=
=nk1Z
-----END PGP SIGNATURE-----

--------------enigFEE7AB69A78FE5A0273AA27B--
