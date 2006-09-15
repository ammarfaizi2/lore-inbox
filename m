Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWIORTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWIORTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWIORTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:19:24 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:2507 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932102AbWIORTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:19:23 -0400
Date: Fri, 15 Sep 2006 19:17:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Oleg Verych <olecom@flower.upol.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Travis H." <solinym@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: design of screen-locks for text-mode sessions
In-Reply-To: <450ABA41.2090203@flower.upol.cz>
Message-ID: <Pine.LNX.4.61.0609151917430.10464@yvahk01.tjqt.qr>
References: <d4f1333a0609110240n3904e5a9g4359c338004008ae@mail.gmail.com>
 <Pine.LNX.4.61.0609111259000.14498@yvahk01.tjqt.qr> <450ABA41.2090203@flower.upol.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hallo, Jan Engelhardt
> who wrote:
>> 
>> screen. Start it. Hit ^A^X. Does not support autolocking though.
>> 
> Wrong:
>
> "idle N lockscreen" in your ~/.screenrc or in cmdline (C-a, C-z i have)

But what password will it use if you have not set one before?


Jan Engelhardt
-- 
