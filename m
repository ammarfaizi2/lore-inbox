Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUGDX3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUGDX3B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGDX3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 19:29:00 -0400
Received: from web51802.mail.yahoo.com ([206.190.38.233]:9611 "HELO
	web51802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265841AbUGDX2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 19:28:53 -0400
Message-ID: <20040704232852.58634.qmail@web51802.mail.yahoo.com>
Date: Sun, 4 Jul 2004 16:28:52 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Slow internet access for 2.6.7bk15&16
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040704165743.GD18688@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so, I checked the latest bk (17) and found that
the fix indicated by the below link has already made
it in and still I see the slow down in ftp transfers
in comparison to 2.6.6 and 2.4.x kernels.  Any
suggestions?

Dual Opteron
Broadcom Ge
using tg3

Thanks!
Phy
--- bert hubert <ahu@ds9a.nl> wrote:
> On Sat, Jul 03, 2004 at 07:41:12PM -0700, Phy Prabab
> wrote:
> > Heelo,
> > 
> > I have been watching a thread concerning the slow
> down
> > with accessing some websites but have not found a
> > resolution to the issue.  
> 
> Probably fixed by
>
http://linus.bkbits.net:8080/linux-2.5/cset@40e47ae2tQ_PIxw_HStw3YgsdJFHow?nav=index.html|ChangeSet@-4d
> 
> -- 
> http://www.PowerDNS.com      Open source, database
> driven DNS Software 
> http://lartc.org           Linux Advanced Routing &
> Traffic Control HOWTO
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
