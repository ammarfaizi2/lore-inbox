Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTLXTGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTLXTGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 14:06:01 -0500
Received: from mx2.mail.ru ([194.67.23.22]:57872 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S263806AbTLXTF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 14:05:58 -0500
Message-ID: <3FE9E391.7060702@mail.ru>
Date: Wed, 24 Dec 2003 14:05:53 -0500
From: Yaroslav Klyukin <skintwin@mail.ru>
User-Agent: Mozilla/5.0 (ICQ: 1045670, AIM: infiniteparticle)
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: aacraid issues
References: <1648C-3LJ-9@gated-at.bofh.it> <164in-3Zu-25@gated-at.bofh.it>
In-Reply-To: <164in-3Zu-25@gated-at.bofh.it>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDB71B501F91045151B454EEC"
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB71B501F91045151B454EEC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mark Haverkamp wrote:
> Try this, someone else with a 2200 had a similar problem that this patch
> fixed. It will apply to 2.6.0.

Thanks for the patch.
The RAID seems to work now without I/O errors.


> ===== drivers/scsi/aacraid/aachba.c 1.20 vs edited =====
> --- 1.20/drivers/scsi/aacraid/aachba.c	Fri May  2 12:30:49 2003
> +++ edited/drivers/scsi/aacraid/aachba.c	Wed Dec  3 15:10:22 2003



--------------enigDB71B501F91045151B454EEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6eORXtaNP/qDgm8RAlEJAJ9H+5YBn1MA1XVu4PMCNGOfehWLZgCfWgBU
Pux3tGkHCWBuGOzt8As3G1o=
=ay0A
-----END PGP SIGNATURE-----

--------------enigDB71B501F91045151B454EEC--

