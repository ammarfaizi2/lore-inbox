Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267214AbUGNLvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUGNLvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 07:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267219AbUGNLvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 07:51:18 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:51211 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S267214AbUGNLvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 07:51:17 -0400
Date: Wed, 14 Jul 2004 19:48:43 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Pavel Machek <pavel@ucw.cz>
cc: netdev@oss.sgi.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
In-Reply-To: <20040714114135.GA25175@elf.ucw.cz>
Message-ID: <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
References: <20040714114135.GA25175@elf.ucw.cz>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/14/2004
 07:51:10 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/14/2004
 07:51:15 PM,
	Serialize complete at 07/14/2004 07:51:15 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jul 2004, Pavel Machek wrote:

> Hi!
>
> What is the status of ipw2100? Is there chance that it would be pushed
> into mainline?
>
> I have few problems with that:
>
> * it will not compile with gcc-2.95. Attached patch fixes one problem
> but more remain.

I've given up hope on that. Don't think it'll ever compile on 2.95. I'm 
using ndiswrapper and it works nicely.

Jeff.
