Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281754AbRKQQky>; Sat, 17 Nov 2001 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281775AbRKQQkp>; Sat, 17 Nov 2001 11:40:45 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:45213 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S281754AbRKQQkc>; Sat, 17 Nov 2001 11:40:32 -0500
Message-Id: <200111171640.RAA22409@post.webmailer.de>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Florian Schmitt <florian@galois.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.15-pre5 - probably something wrong with /proc/cpuinfo.
Date: Sat, 17 Nov 2001 17:40:27 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011117144242Z281758-17408+15441@vger.kernel.org>
In-Reply-To: <20011117144242Z281758-17408+15441@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Same problem here... I just removed this part of the boot script - it works 
for me now. But anyway, this is a kernel issue: a stable kernel shouldn´t 
break userspace apps.

Flo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE79pL7H7Gei80C0lQRAp8xAKCTu1cUX1/yUovibbp2t9de7tqENwCgw/1x
pY09AxkOwbgB6NHFnmQLk3k=
=0wT2
-----END PGP SIGNATURE-----
