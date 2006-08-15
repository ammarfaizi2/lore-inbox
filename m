Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWHONJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWHONJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 09:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWHONJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 09:09:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:19377 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965094AbWHONJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 09:09:04 -0400
Date: Tue, 15 Aug 2006 15:08:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Carsten Otto <carsten.otto@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Daily crashes, incorrect RAID behaviour
In-Reply-To: <13e988610608150542od63a2ecqcbf8684033d9690f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0608151507170.29937@yvahk01.tjqt.qr>
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com> 
 <1155646621.24077.270.camel@localhost.localdomain>
 <13e988610608150542od63a2ecqcbf8684033d9690f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > DriveReadySeekComplete (I do not recall the exact words, sorry) for
>> > one disk
>> Pity the exact text is essential.
>
> Here is the exact message I saw a few weeks ago (posted in here):
>
> ata4: handling error/timeout
> ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
> ata4: status=0x50 { DriveReady SeekComplete }
> sdd: Current: sense key=0x0
>       ASC=0x0 ASCQ=0x0
> Info fid=0x0


Although I do not want to accuse libata, is it possible that a libata bug 
is around?


Jan Engelhardt
-- 
