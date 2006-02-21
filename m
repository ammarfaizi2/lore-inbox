Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbWBUX6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWBUX6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWBUX6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:58:11 -0500
Received: from rtr.ca ([64.26.128.89]:22462 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161253AbWBUX6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:58:09 -0500
Message-ID: <43FBA907.6040906@rtr.ca>
Date: Tue, 21 Feb 2006 18:57:59 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jens Axboe <axboe@suse.de>, Ariel Garcia <garcia@iwr.fzk.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4 libata + AHCI patched for suspend fails on ICH6
References: <200602191958.38219.garcia@iwr.fzk.de> <20060219191859.GJ8852@suse.de> <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0602210903260.8603@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Just to let you know that my Dell i9300 (still!) suspends/resumes (RAM, Disk)
perfectly 100% with your patches applied.

And fails regularly without them.  2.6.16-rc4.

Cheers
