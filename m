Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUALVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266482AbUALVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:36:56 -0500
Received: from [203.152.107.120] ([203.152.107.120]:16769 "HELO
	skieu.myftp.org") by vger.kernel.org with SMTP id S266477AbUALVgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:36:54 -0500
Date: Tue, 13 Jan 2004 10:37:45 +0000 (UTC)
From: haiquy@yahoo.com
X-X-Sender: sk@darkstar.example.net
Reply-To: s_kieu@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: GIVEUP [bootup kernel panic 2.6.x] no root partition detected?
Message-ID: <Pine.LNX.4.53.0401131034450.25789@darkstar.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

Did you try to boot 2.6 kernel using initrd as the initial root. It
should be ok as it is RAM disk,  and from that try to mount / or
run fdisk etc.. to figure out what is wrong with the parition table?

Steve Kieu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAA8p9v07eUvBr8ysRAvvsAJ9oN4UUxxRdudsaxhzSdJ1Z85GI9gCfaVB+
x+39N4AIdBYouucm+jQLrVk=
=859z
-----END PGP SIGNATURE-----
