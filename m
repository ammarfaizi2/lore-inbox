Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbSKXC5U>; Sat, 23 Nov 2002 21:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbSKXC5U>; Sat, 23 Nov 2002 21:57:20 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:7296 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S267155AbSKXC5U> convert rfc822-to-8bit; Sat, 23 Nov 2002 21:57:20 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: matt@mh.dropbear.id.au
Subject: Re: 2.4.19-ck13 oops
Date: Sun, 24 Nov 2002 14:06:11 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211241406.13739.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

Try ck14. ck13 was a temporary release which had problems and was quickly 
superceded by ck14. If the problem remains, use separated patches and dont 
apply the variable timeslice patch.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE94EIjF6dfvkL3i1gRAtS/AJ9l1ZLT4pChRdWuBZqyGUgaoAwzTQCdF5ZI
36hbhcXU7r/f27s58Z9eGNc=
=MoPm
-----END PGP SIGNATURE-----
