Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754014AbWKLFSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbWKLFSE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 00:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754969AbWKLFSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 00:18:03 -0500
Received: from mail.ggsys.net ([69.26.161.131]:18570 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1754014AbWKLFSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 00:18:01 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4556AC74.3010000@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Sat, 11 Nov 2006 23:17:57 -0600
Message-Id: <1163308677.3338.33.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I missed that post. I will add the printk line right
now. I'll let you know the results as soon as it happens
again.

Thanks,


Alberto

On Sun, 2006-11-12 at 00:09 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > The saga continues. It happened again this morning even with the
> > patch:
> ..
> >> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
> >> Try this patch (attached) and report back.
> 
> Did you add the printk() to the patch, as suggested?
> If so, did it log anything ?
> 
> Thanks
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

