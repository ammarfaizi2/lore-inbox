Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbUBZQIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbUBZQFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:05:24 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:57133 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S262816AbUBZQDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:03:53 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Terje Kvernes <terjekv@math.uio.no>
Subject: Re: Serial ATA (SATA) status report
Date: Thu, 26 Feb 2004 15:55:46 +0000
User-Agent: KMail/1.5.3
Cc: Andre Tomt <andre@tomt.net>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <403D5B3D.6060804@pobox.com> <200402261423.56448.m.watts@eris.qinetiq.com> <wxxbrnl3lfe.fsf@nommo.uio.no>
In-Reply-To: <wxxbrnl3lfe.fsf@nommo.uio.no>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402261555.46630.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>   the 3w-xxxx-module works well enough in 32bit mode on AMD64.  sadly
>   enough, we have had some other issues with 64bit mode, but the
>   _driver_ seems to load there as well.

Do these 'issues' prevent the cards from being used at all in 64bit mode on 
AMD-64?

We'd really like to use the 4-port SATA 3Ware card on a Tyan Thunder K8W 
(S2885) but it'd be a bit of a waste if we can only use it in 32bit mode. (I 
assume 32bit mode means you compile for i686 instead of AMD-64 ?)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAPhcCBn4EFUVUIO0RAgYlAKCIdWX36mkFko8kdlyhCtzTcpAgsQCeOCc4
hZYOYnuFKuZLa5v4KJ7XGjI=
=M/Ej
-----END PGP SIGNATURE-----

