Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbSK2URl>; Fri, 29 Nov 2002 15:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbSK2URk>; Fri, 29 Nov 2002 15:17:40 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:42637 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267143AbSK2URk>; Fri, 29 Nov 2002 15:17:40 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH] Module alias and table support
Date: 29 Nov 2002 19:56:00 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnaufhig.ofn.kraxel@bytesex.org>
References: <20021129040120.5F0B72C239@lists.samba.org>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1038599760 25080 127.0.0.1 (29 Nov 2002 19:56:00 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Good!  I think I'll release a 2.5.50 modules megapatch while I'm
>  waiting for Linus to merge.

Good idea, that will simplify testing alot.  Right now I'm trying to
pick patches from the list, see some of them fail to apply, others fail
to build, that is somewhat annonying.  And I don't even start to
complain about architectures != i386 ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
