Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUHYXbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUHYXbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUHYXau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:30:50 -0400
Received: from smtp04.ya.com ([62.151.11.162]:62159 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S266242AbUHYXan convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:30:43 -0400
From: David =?iso-8859-1?q?Mart=EDnez_Moreno?= <ender@debian.org>
Organization: Debian
To: "Pankaj Agarwal" <pankaj@pnpexports.com>
Subject: Re: Help Root Raid
Date: Thu, 26 Aug 2004 01:30:39 +0200
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>, ender@debian.org
References: <002301c485cc$3777fed0$9159023d@dreammachine> <200408191127.37990.ender@debian.org> <000c01c4879d$574ce950$9f59023d@dreammachine>
In-Reply-To: <000c01c4879d$574ce950$9f59023d@dreammachine>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408260130.39772.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Sábado, 21 de Agosto de 2004 18:37, Pankaj Agarwal escribió:
> Hi Ender,
>
> this isn't the case...however i tried by changing the 83 to FD but it
> doesn't worked.
>
> its already enabled and the kernel is reading these partitions as well....i
> guess because of these messages during bootup and shutdown....
>
> Part of BOOTUP message ...
> "
> autodetecting Raid Arrays
> autorun...
> ...autorun DONE
> "
>
> Part of shutdown message ....
> "
> md recovery thread got woken
> md recovery thread finished
> mdrecoveryd(7) flushing signals
> Stopping all md devices.
> "
> Hope it helps you in helping me further.

	Hello, Pankaj. Could you please send us a copy of your dmesg output? That is 
the first thing you must do in order to diagnose problems.

	Thanks,


		Ender.
- -- 
Network engineer
Debian Developer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBLSEfWs/EhA1iABsRAnHKAJwPuiNFYCncG6mfpGfkZcbg6Ug2OwCdFVS9
hNfF9qkIkYyZsXIvfOibUWA=
=l9uK
-----END PGP SIGNATURE-----
