Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSENNnP>; Tue, 14 May 2002 09:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315722AbSENNnO>; Tue, 14 May 2002 09:43:14 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:21685 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S315721AbSENNnM>;
	Tue, 14 May 2002 09:43:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: dmarkh@cfl.rr.com
Subject: Re: Combined low latency & performance patches for 2.4.18
Date: Tue, 14 May 2002 23:42:52 +1000
X-Mailer: KMail [version 1.4]
In-Reply-To: <20020429142443.A62481333@pc.kolivas.net> <20020430230105.D5CA01A0AA@pc.kolivas.net> <3CCFA3BD.664EE747@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205142343.10555.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark (and lkml readers)

On further testing from the feedback I've gotten it seems that this patch 
works fine for gcc 2.95.3 and gcc 3.0.3+

There is definitely a problem with trying to compile it with gcc2.96 

Cheers,
Con Kolivas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE84RRfF6dfvkL3i1gRAmy0AJ91EYI+juz0W92oQzZsRLkgg1ggTwCfT+EY
G/aXt+YD49+3mh2UIDIOlyo=
=bb9b
-----END PGP SIGNATURE-----
