Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTKCF4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 00:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbTKCF4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 00:56:33 -0500
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:29312 "EHLO
	mail.longlandclan.hopto.org") by vger.kernel.org with ESMTP
	id S261914AbTKCF4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 00:56:31 -0500
Message-ID: <3FA5EE0C.30006@longlandclan.hopto.org>
Date: Mon, 03 Nov 2003 15:56:28 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gulu gulu <rgshi2002@yahoo.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux on SGI O2
References: <20031102120740.13306.qmail@web80702.mail.yahoo.com>
In-Reply-To: <20031102120740.13306.qmail@web80702.mail.yahoo.com>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

gulu gulu wrote:

> Hallo all,
> 
>    can anyone tell me if linux already supports SGI
> O2.
> I have 2 SGIs. It will be pity to leave them there.

Certainly can, I'm not sure how well, the information I have here seems 
to suggest that you need to use a serial console (there's no framebuffer 
support), but otherwise, the SGI O2 will certainly run Linux.

Some useful links:
	http://www.debian.org/ports/mips/
		- Debian MIPS{,-el} port

	http://dev.gentoo.org/~kumba/mips/mips.html
		- Gentoo for MIPS

These are mainly orientated at the Indy, especially the latter one, 
however there is some information on the O2.
- -- 
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/pe4MIGJk7gLSDPcRAnk8AJ4jY4MoNHtZGXKsrLrLg+JyCpuR/QCfefEE
tXPrRh597dYsB8BUor6lL3g=
=WTXm
-----END PGP SIGNATURE-----

