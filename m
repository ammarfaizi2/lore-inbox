Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753980AbWKLFJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbWKLFJM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 00:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbWKLFJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 00:09:12 -0500
Received: from rtr.ca ([64.26.128.89]:58116 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1753980AbWKLFJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 00:09:11 -0500
Message-ID: <4556AC74.3010000@rtr.ca>
Date: Sun, 12 Nov 2006 00:09:08 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Alberto Alonso <alberto@ggsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qstor driver -> irq 193: nobody cared
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca> <1163180185.28843.13.camel@w100>
In-Reply-To: <1163180185.28843.13.camel@w100>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Alonso wrote:
> The saga continues. It happened again this morning even with the
> patch:
..
>> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
>> Try this patch (attached) and report back.

Did you add the printk() to the patch, as suggested?
If so, did it log anything ?

Thanks
