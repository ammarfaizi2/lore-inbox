Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266409AbSKKMIR>; Mon, 11 Nov 2002 07:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266427AbSKKMIQ>; Mon, 11 Nov 2002 07:08:16 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:8092 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266409AbSKKMIQ>; Mon, 11 Nov 2002 07:08:16 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: second error, bttv 2.5.47
Date: 11 Nov 2002 12:55:44 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnasva6g.c13.kraxel@bytesex.org>
References: <1036990995.24251.7.camel@flat41>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1037019344 12324 127.0.0.1 (11 Nov 2002 12:55:44 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
>  drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared
>  (first use in this function)

Patches for this and other v4l issues are available from
	http://bytesex.org/patches/2.5/

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
