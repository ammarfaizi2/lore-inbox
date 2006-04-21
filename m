Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWDUPIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWDUPIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDUPIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:08:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7346 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750993AbWDUPIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:08:47 -0400
Date: Fri, 21 Apr 2006 17:08:44 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Buesch <mb@bu3sch.de>
cc: mikado4vn@gmail.com, linux-kernel@vger.kernel.org,
       Hua Zhong <hzhong@gmail.com>
Subject: Re: [PATCH] Rename "swapper" to "idle"
In-Reply-To: <200604211656.50485.mb@bu3sch.de>
Message-ID: <Pine.LNX.4.61.0604211708300.31515@yvahk01.tjqt.qr>
References: <000301c66503$3bbd8060$0200a8c0@nuitysystems.com>
 <4448EEE7.5010708@gmail.com> <200604211656.50485.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Swapper does not do these things. It just happens to be "running" at that time (and it is always running if the system is idle).
>> >
>> > IOW, it is indeed an "idle" process. In fact, all it does is cpu_idle().
>> 
>> Really? Are your sure that swapper only does cpu_idle()???
>
>Yes.
>Idle is by definition Nothing.
>

So call it "voidd" :>


Jan Engelhardt
-- 
