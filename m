Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130619AbRCLUhe>; Mon, 12 Mar 2001 15:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130623AbRCLUhY>; Mon, 12 Mar 2001 15:37:24 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:2294 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S130619AbRCLUhQ>; Mon, 12 Mar 2001 15:37:16 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103122035.f2CKZdA00650@webber.adilger.int>
Subject: Re: linux localization
In-Reply-To: <Pine.LNX.4.21.0103120946220.2102-100000@imladris.rielhome.conectiva>
 from Rik van Riel at "Mar 12, 2001 09:47:26 am"
To: Rik van Riel <riel@conectiva.com.br>
Date: Mon, 12 Mar 2001 13:35:39 -0700 (MST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, XingFei <xing.fei@fujixerox.co.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XingFei writes:
> My work will concern with the internationalization of Linux
> So, could anybody tell me what kinds of features should be in the
> consideration when linux be localized from english to Japanese or chinese,
> say using 2 bytes character set.

Is this for Linux console i18n?  TurboLinux has a kernel patch (2.2)
for Unicode support on the console (with CJK input):

http://www.turbolinux.com.cn/TLDN/chinese/project/unicon/

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
