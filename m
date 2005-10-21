Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVJUSu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVJUSu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVJUSu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:50:56 -0400
Received: from magic.adaptec.com ([216.52.22.17]:29069 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965081AbVJUSuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:50:55 -0400
Message-ID: <43593884.7000800@adaptec.com>
Date: Fri, 21 Oct 2005 14:50:44 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <43593100.5040708@pobox.com>
In-Reply-To: <43593100.5040708@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 18:50:49.0295 (UTC) FILETIME=[5A800DF0:01C5D670]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05 14:18, Jeff Garzik wrote:
> This illustrates you fundamentally don't understand a lot of Linux, and 
> SCSI too.
> 
> Several non-blkdev device classes (Christoph listed them) use block 
> layer request_queue for command transit, as does SG_IO and /dev/sg.

When people start getting personal you know that they're losing it.

> We have plenty of specs.  It's called source code.
> 
> You don't understand the Linux development process (think its more 
> political than technical) and you don't understand even what a block 
> driver is, and you wonder why you have difficulty getting code into the 
> kernel?

Again, when people start getting personal, you know that they are losing it.

Thank you for spreading FUD -- I'm sure you've impressed your managament,
how great of a Linux programmer you are and how I don't know anything.
I'd suggest you keep pushing the politics _behind_ the scences.

Have a good day,
	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
