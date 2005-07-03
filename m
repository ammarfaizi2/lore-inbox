Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVGCCSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVGCCSM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 22:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVGCCSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 22:18:11 -0400
Received: from host.atlantavirtual.com ([209.239.35.47]:15746 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S261340AbVGCCSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 22:18:07 -0400
Subject: Re: ramdisk max size limitation?
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050703011524.1581.qmail@web51802.mail.yahoo.com>
References: <20050703011524.1581.qmail@web51802.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1120357030.3566.1.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 02 Jul 2005 22:17:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy,

mount tmpfs -t tmpfs -o size=600m /mnt/here


Works for me on my 2.4.29 kernel.  600MB tmpfs.


regards,

fd

On Sat, 2005-07-02 at 21:15, Phy Prabab wrote:
> Hello,
> 
> Is there a limitation to the max size you can create a
> ramdisk?  I have a 1.5G system and I am trying to
> allocate a 1G RAM disk, yet no matter what I do, the
> max I can create and use is 512M.  Is there a way to
> get over this limitation?
> 
> Thanks for the help!
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

