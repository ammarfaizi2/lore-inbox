Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJPTYH>; Wed, 16 Oct 2002 15:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbSJPTYH>; Wed, 16 Oct 2002 15:24:07 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:6048 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261323AbSJPTYF>; Wed, 16 Oct 2002 15:24:05 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: v4l2 in 2.5.x?
Date: 16 Oct 2002 19:37:55 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnaqrg0j.gcm.kraxel@bytesex.org>
References: <20021016144309.27994.qmail@web11304.mail.yahoo.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1034797075 16791 127.0.0.1 (16 Oct 2002 19:37:55 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher wrote:
>  What's the status on v4l2?  I thought it was supposed to go in during
>  the 2.5 series.  I seem to recall some stuff going in around 2.5.5ish,
>  but as I recall that was just some revamping of v41.  Just curious...

Still work-in-progress.  The v4l2 API currently is reworked a bit.  No
fundamental changes, but alot of small cleanups.  Check the video4linux
list archives for more details.

I still plan to get v4l2 in 2.5 before the freeze deadline.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
