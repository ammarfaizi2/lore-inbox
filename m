Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266059AbUALF5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 00:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266060AbUALF5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 00:57:49 -0500
Received: from h80ad24b1.async.vt.edu ([128.173.36.177]:31616 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266059AbUALF5s (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 00:57:48 -0500
Message-Id: <200401120557.i0C5v23e003260@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Stephen D. Williams" <sdw@lig.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High Quality Random sources, was: Re: SecuriKey 
In-Reply-To: Your message of "Sun, 11 Jan 2004 23:10:47 EST."
             <40021E47.1070406@lig.net> 
From: Valdis.Kletnieks@vt.edu
References: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com> <4001ECBE.1020009@lig.net> <200401112238.32117.tabris@tabris.net> <200401112247.59418.tabris@tabris.net>
            <40021E47.1070406@lig.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-767786970P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jan 2004 00:57:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-767786970P
Content-Type: text/plain; charset=us-ascii

On Sun, 11 Jan 2004 23:10:47 EST, "Stephen D. Williams" said:

> OTP absolutely requires that you share the OTP out of band, i.e. you 
> twin a capture of random data.  Any transfer makes it as vulnerable as 
> the transfer method.

The single most common OTP-related offense of Schneier's "snake oil crypto"
has got to be the fact it's almost never only used exactly once and then discarded.

So sure you can load 200 meg of OTP into the dongle before you leave the spy agency
on a mission.  The fun starts when you get to the 201st megabyte of data. :)

--==_Exmh_-767786970P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAAjctcC3lWbTT17ARAqDMAKCkqRAUf1cI2WrI2ZYa73VJ7nnruACgmOMK
VDh3SnQm97nMZUnbROF59pQ=
=/9LN
-----END PGP SIGNATURE-----

--==_Exmh_-767786970P--
