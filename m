Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUHWRV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUHWRV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUHWRVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:21:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:47820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266183AbUHWRTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:19:32 -0400
X-Authenticated: #4512188
Message-ID: <412A271F.3040802@gmx.de>
Date: Mon, 23 Aug 2004 19:19:27 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040815)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Schmidlkofer <menion@asylumwear.com>
CC: Con Kolivas <kernel@kolivas.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com>
In-Reply-To: <412A2398.8050702@asylumwear.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Schmidlkofer wrote:
| I don't know what or why, but I am experiancing a nightmare with
| interactivity and heavy nfs use.   I am using Gentoo, and I have my
| portage tree exported from a central server.   Trying to do an emerge
| update world is taking forever.

[snip]

Yup I think I have a regression here, as well. I remember an older
version of ck exhibited this, but the last one for 2.6.7 did work well
(I think even the one for 2.8.6-rc4 was ok), IIRC. In my case, when
doing a (niced) compile in background, some windows react very slow, ie
Mozilla Thunderbird takes ages to switch trough mails or cliking on an
icon in kde to load up konsole takes about 10seconds or more (shoud come
up <1sec normally).

Using 2.8.6.1-ck4

HTH,

Prakash
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKicfxU2n/+9+t5gRAqSlAKDrX1TZpPH8Pf+G/NjO6vnEGUwsVACfaKAA
WQcbUxP37FR7ZOf26JZhWGs=
=m3OJ
-----END PGP SIGNATURE-----
