Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWA3J0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWA3J0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWA3J0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:26:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44781 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932161AbWA3J0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:26:48 -0500
Date: Mon, 30 Jan 2006 10:26:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
In-Reply-To: <43AF7F00.50304@ums.usu.ru>
Message-ID: <Pine.LNX.4.61.0601301025550.6405@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0512242300360.29877@yvahk01.tjqt.qr>
 <43AE2B06.4010906@ums.usu.ru> <Pine.LNX.4.61.0512252209380.15152@yvahk01.tjqt.qr>
 <43AF7F00.50304@ums.usu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Differences between our versions are described below.
>
>> What do you think we should do? I have not given this fix any thought,
>> because it applied fine for long time (+/- fuzz), so I cannot comment on
>> anything in your version being better or not.
>
> If you really don't care about characters beyond 0xffff (but see below),
> please consider applying this on top of your patch:

Could you just send the whole thing to mainline once 2.6.16 is out? Thanks.




Jan Engelhardt
-- 
