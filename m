Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269425AbUINPff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269425AbUINPff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUINPff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:35:35 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:17560 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269416AbUINPew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:34:52 -0400
Message-ID: <41470F3A.1060308@rtr.ca>
Date: Tue, 14 Sep 2004 11:33:14 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net> <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain> <41470BBD.7060700@pobox.com> <20040914152509.GA27892@suse.de>
In-Reply-To: <20040914152509.GA27892@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan says it's unsafe for some of his flash cards, and I do believe they
> say they have write caching enabled.

Flash cards should be detectable --> many of them will claim
to implement the CFA feature set.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
