Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVGUVE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVGUVE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVGUVE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:04:28 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:30431 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261848AbVGUVE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:04:26 -0400
Message-ID: <42E00DD3.9060407@trn.iki.fi>
Date: Fri, 22 Jul 2005 00:04:19 +0300
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Supermount
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4384672D488634C66E35B02A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4384672D488634C66E35B02A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Is there a reason why this magnificient piece of software is not already
in the mainline? It seems to be working very well and provides
functionality that simply isn't available otherwise.

For those who are not familiar with it: this system does on-demand
mounting when the mount point is accessed and automatically umounts
afterwards. Unlike autofs, this does not require a special automount
filesystem to be mounted, but the actual filesystems can be directly
mounted where-ever. Also, it "just works" and the CD drive will eject
when the button is pressed, without having to wait for the umount
timeout to pass. I haven't looked inside to find out HOW it actually
does it, because I simply don't care, as long as it just works.

- Tronic -

--------------enig4384672D488634C66E35B02A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC4A3YOBbAI1NE8/ERAgalAKCBetdcnObcoisFLd89p3mRbnwi1gCgmCna
m6H3WInSGYXKCJiAz/kIspM=
=4dYH
-----END PGP SIGNATURE-----

--------------enig4384672D488634C66E35B02A--
