Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280904AbRKYP7T>; Sun, 25 Nov 2001 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280907AbRKYP7K>; Sun, 25 Nov 2001 10:59:10 -0500
Received: from yinyang.hjsoft.com ([205.231.166.38]:9735 "EHLO
	yinyang.hjsoft.com") by vger.kernel.org with ESMTP
	id <S280904AbRKYP7B>; Sun, 25 Nov 2001 10:59:01 -0500
Date: Sun, 25 Nov 2001 10:55:31 -0500 (EST)
From: "Mr. Shannon Aldinger" <god@yinyang.hjsoft.com>
Reply-To: god@yinyang.hjsoft.com
To: linux-kernel@vger.kernel.org
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <1006702226.1316.2.camel@gandalf.chabotc.com>
Message-ID: <Pine.LNX.4.40.0111251053390.7809-100000@yinyang.hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25 Nov 2001, Chris Chabot wrote:

> Of 430Mb, (counting ps aux res values), just below 80 Mb is used by the
> applications. the rest is just 'missing'.
>

Are you using tmpfs, that had problems in the earlier 2.4.x's IIRC.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iEYEARECAAYFAjwBFHwACgkQwtU6L/A4vVDmzgCeITZ6/njcztWClfPfthOGTnfE
io8An0l2BPZIyJGhhXijFfYoTl/OsTyL
=Q2bB
-----END PGP SIGNATURE-----


