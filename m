Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUFJSKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUFJSKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUFJSKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:10:11 -0400
Received: from port-212-202-157-212.reverse.qsc.de ([212.202.157.212]:12234
	"EHLO bender.portrix.net") by vger.kernel.org with ESMTP
	id S262208AbUFJSKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:10:05 -0400
Message-ID: <40C8A3F1.7020007@portrix.net>
Date: Thu, 10 Jun 2004 20:09:53 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lee <steve@tuxsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU1: 00(02) && APIC error on CPU0: 00(02)
References: <000401c44f13$da874e90$8119fea9@pluto>
In-Reply-To: <000401c44f13$da874e90$8119fea9@pluto>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDEE450B840EDC81292763A7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDEE450B840EDC81292763A7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Steve Lee wrote:
> APIC error on CPU1: 00(02)
> APIC error on CPU0: 00(02)

Is this a Dual AMD Platform? If yes, are this real MPs or just modded 
XPs? I've had this kind of error for years on a dual AMD with modded XPs 
on a Tyan 2460 - until now, no processor broke down. The APIC is very 
picky on this board, judging different posts from the internet.

Jan

--------------enigFDEE450B840EDC81292763A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAyKP2LqMJRclVKIYRAky8AKCF3VLnQQBIGbHJmSXp6INd7G7SxwCfUA/A
AbmuGVaxSTJlJeg1w0agVX8=
=dISh
-----END PGP SIGNATURE-----

--------------enigFDEE450B840EDC81292763A7--
