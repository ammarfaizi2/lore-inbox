Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWGGPGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWGGPGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGGPGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:06:32 -0400
Received: from mail.phnxsoft.com ([195.227.45.4]:22288 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932185AbWGGPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:06:31 -0400
Message-ID: <44AE7861.8090103@imap.cc>
Date: Fri, 07 Jul 2006 17:06:09 +0200
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1: printk delays
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9605.6000601@imap.cc>	 <1152229599.24656.175.camel@cog.beaverton.ibm.com>	 <44ADA84A.9000603@imap.cc> <1152233897.24656.179.camel@cog.beaverton.ibm.com>
In-Reply-To: <1152233897.24656.179.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD71973F5F0E9F1EFE2B7DA7D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD71973F5F0E9F1EFE2B7DA7D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

john stultz wrote:
> Hmmm. Just to make sure I understand the situation: If you log in via
> ssh, and run dmesg, you do see your driver's output, but that output
> just doesn't get to syslog until you press a key on your keyboard?

Exactly.

Thanks,
Tilman

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)

--------------enigD71973F5F0E9F1EFE2B7DA7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErnhpMdB4Whm86/kRAu0/AJ40L750k7eamfeWl7JayKe6UeMnYACaA+20
L1rgHcKNGtEo27OEOTB3HbA=
=oHBZ
-----END PGP SIGNATURE-----

--------------enigD71973F5F0E9F1EFE2B7DA7D--
