Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVACVP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVACVP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVACVOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:14:30 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:59299 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261796AbVACVHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:07:15 -0500
Message-ID: <41D9B3F2.30302@kolivas.org>
Date: Tue, 04 Jan 2005 08:06:58 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rajsekar <rajsekar@cse.iDELTHISitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1 ck1 patch does not include supermount
References: <m3pt0mjz1n.fsf@rajsekar.pc>
In-Reply-To: <m3pt0mjz1n.fsf@rajsekar.pc>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC40EA1B711FC7D30C81DE1BF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC40EA1B711FC7D30C81DE1BF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rajsekar wrote:
> I tried out 2.6.10-rc1 ck1 patch.  The patches directory suggests that the
> supermount patch is applied but AFAIK they are not applied.  I had to
> manually apply the patch (downloaded the diff from con kolivas's site).

Correct. I maintain the patch so that it is alive and well because many 
(of us) use it. However I don't include it in the -ck patchset by 
default since I reserve -ck for patches that affect performance in some 
way only.

Cheers,
Con

--------------enigC40EA1B711FC7D30C81DE1BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2bP0ZUg7+tp6mRURAu1vAJ4rxq/4Dkq9uAFgrGSNQO9jAYH+FwCfb81X
NTQkL9zn8IXkZentUlN0bvA=
=5Cr0
-----END PGP SIGNATURE-----

--------------enigC40EA1B711FC7D30C81DE1BF--
