Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSEOVGO>; Wed, 15 May 2002 17:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316504AbSEOVGN>; Wed, 15 May 2002 17:06:13 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:26450 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316503AbSEOVGM> convert rfc822-to-8bit;
	Wed, 15 May 2002 17:06:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: h323 compile problems
Date: Wed, 15 May 2002 22:24:05 +0200
X-Mailer: KMail [version 1.4]
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Paul Rusty Russell <Paul.Russell@rustcorp.com.au>,
        Michael Cohen <mjc@ohdarn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205152224.05251.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Michael Cohen and i got an issue with h323. Have a look:

ip_nat_h323.c:56: warning: braces around scalar initializer
ip_nat_h323.c:56: warning: (near initialization for `h245.name')
ip_nat_h323.c:64: initializer element is not computable at load time
ip_nat_h323.c:64: (near initialization for `h245.tuple.dst.u.all')

You have a fix for this?

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824  080A 569D E2E3 DB44 1A16
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.


